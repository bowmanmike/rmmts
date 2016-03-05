class ChoreDueNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(chore)
    MateMailer.chore_due(chore).deliver_later
  end

end
