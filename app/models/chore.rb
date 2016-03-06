class Chore < ActiveRecord::Base
  include ActiveModel::Dirty
  include Recurrence

  belongs_to :house
  belongs_to :mate
  belongs_to :creator, class_name: Mate

  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  validates :frequency_unit, presence: true, if: :recurring?
  validates :frequency_integer, presence: true, if: :recurring?
  validates :frequency_weekday, presence: true, if: :recurring_weekly?
  validates :frequency_integer, numericality: {only_integer: true}, allow_blank: true
  validates_inclusion_of :frequency_unit, in: ["days", "weeks", "months", "years"], allow_blank: true
  validates_inclusion_of :frequency_weekday, in: Date::DAYNAMES, allow_blank: true
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past

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
    unless self.complete
      if self.mate
        ChoreReminderJob.set(wait_until: (self.due_date - 1.days).to_date.noon).perform_later(self)
        self.update_column(:reminder_id, Delayed::Job.where(queue: :chores).last.id)
      else
        GroupChoreReminderJob.set(wait_until: (self.due_date - 1.days).to_date.noon).perform_later(self)
        self.update_column(:reminder_id, Delayed::Job.where(queue: :chores).last.id)
      end
      ChoreDueNotificationJob.set(wait_until: self.due_date.noon).perform_later(self)
      self.update_column(:due_notification_id, Delayed::Job.where(queue: :chores).last.id)
    end
    UpdateChoreDueDateJob.set(wait_until: self.due_date).perform_later(self)
    self.update_column(:update_due_date_job_id, Delayed::Job.where(queue: :chores).last.id)
  end


  def check_status
    return if !self.recurring?
    update_due_date
    self.update_column(:complete, false)
    self.update_column(:reminder_id, nil)
    self.update_column(:due_notification_id, nil)
    self.update_column(:update_due_date_job_id, nil)
    update_reminder
    # self.complete = false
    # self.reminder_id = nil
    # self.due_notification_id = nil
    # self.update_due_date_job_id = nil
    # self.save
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

  def create_notifications
    self.house.mates.each do |mate|
      self.notifications.create(mate_id: mate.id, email: true, sms: false)
    end
  end

  def check_claimed?
    self.mate_id?
  end

  def sms_reminder(mate)
    @twilio_number = ENV["TWILIO_NUMBER"]
    @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    time_str = self.due_date.strftime("%a, %e %b %Y")
    reminder = "Hey #{mate.first_name}, don't for get to #{self.name} before #{time_str}!"
    message = @client.account.messages.create(
      from: @twilio_number,
      to: mate.phone_number,
      body: reminder
    )
    puts "SMS from: #{message.from}"
    puts "SMS to: #{mate.phone_number}"
    puts "SMS body: #{reminder}"
  end

end
