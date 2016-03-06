class GroupChoreReminderJob < ActiveJob::Base
  queue_as :chores

  def perform(chore)
    chore.house.mates.each do |mate|
      notification = mate.notifications.find_by(chore_id: chore.id)
      if notification.email?
        MateMailer.chore_notification(chore, mate).deliver_later
      end
      if notification.sms?
        # chore.sms_reminder(mate)
      end
    end
  end

end
