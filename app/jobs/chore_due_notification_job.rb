class ChoreDueNotificationJob < ActiveJob::Base
  queue_as :chores

  def perform(chore)
    @chore = chore
    if @chore.mate
      MateMailer.chore_due(@chore, @chore.mate).deliver_later
    else
      @chore.house.mates.each do |mate|
        MateMailer.chore_due(@chore, mate).deliver_later
      end
    end
  end

end
