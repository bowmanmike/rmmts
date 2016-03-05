class ExpenseDueNotificationJob < ActiveJob::Base
  queue_as :expenses

  def perform(expense)
    @expense = expense
    @expense.house.mates.each do |mate|
      MateMailer.expense_due(@expense, mate).deliver_later
    end
  end

end
