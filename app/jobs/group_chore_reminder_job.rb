class GroupChoreReminderJob < ActiveJob::Base
  queue_as :chores

  def perform(chore)
    chore.house.mates.each do |mate|
      notification = mate.notifications.find_by(chore_id: chore.id)
      if notification.email?
        MateMailer.chore_notification(chore, mate).deliver_later
      elsif notification.sms?
        puts "Sending SMS"
      end
    end
  end

end
