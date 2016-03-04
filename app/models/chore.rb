class Chore < ActiveRecord::Base
  include ActiveModel::Dirty

  belongs_to :house
  belongs_to :mate
  belongs_to :creator, class_name: Mate

  validates :name, presence: true
  validates :frequency_integer, numericality: {only_integer: true}
  validates :frequency_unit, presence: true
  validates :due_date, presence: true

  after_save :update_reminder

  def update_reminder
    if self.reminder_id && self.due_notification_id
      Delayed::Job.find(self.due_notification_id).delete
      Delayed::Job.find(self.reminder_id).delete
      self.update_column(:reminder_id, nil)
      self.update_column(:due_notification_id, nil)

      if self.complete
        self.check_status
      else
        self.set_reminder
      end
      return
    end
    self.set_reminder
  end

  def set_reminder
    if self.mate
      ChoreReminderJob.set(wait_until: (self.due_date - 1.days).to_date.noon).perform_later(self)
      self.update_column(:reminder_id, Delayed::Job.last.id)
    else
      GroupChoreReminderJob.set(wait_until: (self.due_date - 1.days).to_date.noon).perform_later(self)
      self.update_column(:reminder_id, Delayed::Job.last.id)
    end
    ChoreDueNotificationJob.set(wait_until: self.due_date).perform_later(self)
    self.update_column(:due_notification_id, Delayed::Job.last.id)
  end


  def check_status
    return if !self.recurring?
    if self.complete?
      self.complete = false
      update_due_date
    else
      update_due_date
    end
  end

  def update_due_date
    options = { self.frequency_unit.to_sym => self.frequency_integer }
    self.due_date = self.due_date.advance(options)
    self.due_notification_id = nil
    self.reminder_id = nil
    self.save
  end

end
