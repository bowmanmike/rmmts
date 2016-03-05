class ExpenseReminderJob < ActiveJob::Base
  queue_as :expenses

  def perform(expense)
    @expense = expense
    @expense.house.mates.each do |mate|
      MateMailer.expense_reminder(@expense, mate).deliver_later
    end
  end
  
end
