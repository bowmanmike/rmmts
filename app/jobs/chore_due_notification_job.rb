class ChoreDueNotificationJob < ActiveJob::Base
  queue_as :default
  after_enqueue :notify_enqueued

  def perform(chore)
    MateMailer.chore_due(chore).deliver_later
    chore.check_status
  end

  def notify_enqueued
    puts "CHORE DUE NOTIFICATION ENQUEUED"
  end
end
