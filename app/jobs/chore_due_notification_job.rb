class ChoreDueNotificationJob < ActiveJob::Base
  queue_as :chores

  def perform(chore)
    MateMailer.chore_due(chore).deliver_later
  end

end
