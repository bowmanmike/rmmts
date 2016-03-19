class Expense < ActiveRecord::Base
  include Recurrence
  include ActiveModel::Dirty

  belongs_to :house
  has_many :payments
  has_many :mates, through: :payments

  validates :name, presence: true
  validates :frequency_unit, presence: true, if: :recurring?
  validates :frequency_integer, presence: true, if: :recurring?
  validates :frequency_weekday, presence: true, if: :recurring_weekly?
  validates :frequency_integer, numericality: {only_integer: true}, allow_blank: true
  validates_inclusion_of :frequency_unit, in: ["days", "weeks", "months", "years"], allow_blank: true
  validates_inclusion_of :frequency_weekday, in: Date::DAYNAMES, allow_blank: true
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past

  before_save :update_payment_due_dates, if: :due_date_changed?
  before_destroy :delete_associated_jobs
  after_save :update_reminder

  def recurring?
    recurring == true
  end

  def recurring_weekly?
    ( recurring == true ) && ( frequency_unit == "week" )
  end

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Due date can't be in the past")
    end
  end

  def update_reminder
    if self.reminder_id && self.due_notification_id
      Delayed::Job.find(self.reminder_id).delete if Delayed::Job.exists?(self.reminder_id)
      Delayed::Job.find(self.due_notification_id).delete
      Delayed::Job.find(self.update_due_date_job_id).delete
      self.update_column(:reminder_id, nil)
      self.update_column(:due_notification_id, nil)
      self.update_column(:update_due_date_job_id, nil)
      self.set_reminder
      return
    end
    if self.update_due_date_job_id
      Delayed::Job.find(self.update_due_date_job_id).delete if Delayed::Job.exists?(self.update_due_date_job_id)
    end
    self.set_reminder
  end

  def set_reminder
    unless self.paid
      ExpenseReminderJob.set(wait_until: (self.due_date - 1.days).to_date.noon).perform_later(self)
      self.update_column(:reminder_id, Delayed::Job.where(queue: :expenses).last.id)
      ExpenseDueNotificationJob.set(wait_until: self.due_date.noon).perform_later(self)
      self.update_column(:due_notification_id, Delayed::Job.where(queue: :expenses).last.id)
    end
    UpdateExpenseDueDateJob.set(wait_until: self.due_date.end_of_day).perform_later(self)
    self.update_column(:update_due_date_job_id, Delayed::Job.where(queue: :expenses).last.id)
  end


  def check_status
    return if !self.recurring?
    update_due_date
    self.update_column(:paid, false)
    self.update_column(:reminder_id, nil)
    self.update_column(:due_notification_id, nil)
    self.update_column(:update_due_date_job_id, nil)
    update_reminder
  end

  def update_due_date
    options = { self.frequency_unit.to_sym => self.frequency_integer }
    self.update_column(:due_date, self.due_date.advance(options))
  end

  def delete_associated_jobs
    Delayed::Job.find(self.reminder_id).delete if Delayed::Job.exists?(self.reminder_id)
    Delayed::Job.find(self.due_notification_id).delete if Delayed::Job.exists?(self.due_notification_id)
    Delayed::Job.find(self.update_due_date_job_id).delete if Delayed::Job.exists?(self.update_due_date_job_id)
  end

  def amount_owing
    self.current_cycle_total_payments - self.amount
  end

  def current_cycle_payments
    payments = []
    self.payments.each do |payment|
      payments << payment if payment.target_due_date == self.due_date
    end
    payments
  end

  def current_cycle_total_payments
    total = []
    self.current_cycle_payments.each do |payment|
      total << payment.amount
    end
    if total.reduce(:+) == nil
      0
    else
      total.reduce(:+)
    end
  end

  def current_cycle_mate_payments(mate)
    mate_payments = []
    self.current_cycle_payments.each do |payment|
      mate_payments << payment if payment.mate_id == mate.id
    end
    mate_payments
  end

  def current_cycle_total_mate_payments(mate)
    mate_total = []
    self.current_cycle_mate_payments(mate).each do |payment|
      mate_total << payment.amount
    end
    if mate_total.reduce(:+) == nil
      0
    else
      mate_total.reduce(:+)
    end
  end

  def amount_owed_by(mate)
    self.current_cycle_total_mate_payments(mate) - self.mate_amount
  end

  def mate_amount
    (self.amount / self.house.mates.size).round(2)
  end

  def has_paid?(mate)
    self.mate_amount <= self.current_cycle_total_mate_payments(mate)
  end

  def is_paid?
    self.amount <= self.current_cycle_total_payments
  end

  def update_payment_due_dates
    original_due_date = self.changes[:due_date][0]
    self.payments.where(target_due_date: original_due_date).each do |payment|
      payment.update_column(:target_due_date, self.due_date)
    end
  end

  def create_dummy_expenses
    date_ary = self.calculate_future_due_dates
    dummy_expenses = []
    date_ary.each do |date|
      dummy_expenses << Expense.new(id: self.id, house_id: self.house_id, name: self.name, due_date: date)
    end
    dummy_expenses
  end
end
