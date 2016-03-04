class ChoreReminderJob < ActiveJob::Base
  queue_as :default

  def perform(chore)
    MateMailer.chore_notification(chore, chore.mate).deliver_later
  end


end
