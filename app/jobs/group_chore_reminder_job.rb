class GroupChoreReminderJob < ActiveJob::Base
  queue_as :chores

  def perform(chore)
    chore.house.mates.each do |mate|
      MateMailer.chore_notification(chore, mate).deliver_later 
    end
  end

end
