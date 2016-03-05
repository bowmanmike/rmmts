class UpdateExpenseDueDateJob < ActiveJob::Base
  queue_as :expenses

  def perform(expense)
    expense.check_status
  end
end
