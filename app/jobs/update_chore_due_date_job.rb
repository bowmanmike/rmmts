class UpdateChoreDueDateJob < ActiveJob::Base
  queue_as :default

  def perform(chore)
    chore.check_status
  end
end
