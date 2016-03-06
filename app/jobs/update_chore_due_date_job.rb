class UpdateChoreDueDateJob < ActiveJob::Base
  queue_as :chores

  def perform(chore)
    chore.check_status
  end

end
