class GroupChoreReminderJob < ActiveJob::Base
  queue_as :default
  after_enqueue :notify_enqueued

  def perform(chore)
    chore.house.mates.each do |mate|
      MateMailer.chore_notification(chore, mate).deliver_later
    end
  end

  def notify_enqueued
    puts "PATRICKS CALLBACK: I WAS ENQUEUED!!!!!! AND THIS IS A GROUP MAILER JOB"
  end
end
