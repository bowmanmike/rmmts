class ChoreReminderJob < ActiveJob::Base
  queue_as :chores

  def perform(chore)
    notification = chore.notifications.find_by(mate_id: chore.mate_id)
    if notification.email?
      MateMailer.chore_notification(chore, chore.mate).deliver_later
    end

    if notification.sms?
      puts "Sending SMS"
    end
  end


end
