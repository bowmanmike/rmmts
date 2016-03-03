class ChoreReminderJob < ActiveJob::Base
  queue_as :default
  after_enqueue :notify_enqueued

  def perform(chore)
    MateMailer.chore_notification(chore, chore.mate).deliver_later
  end

  def notify_enqueued
    puts "PATRICKS CALLBACK: I WAS ENQUEUED!!!!!!"
  end

end
