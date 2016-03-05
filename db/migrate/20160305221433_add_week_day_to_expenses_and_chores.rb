class AddWeekDayToExpensesAndChores < ActiveRecord::Migration
  def change
    add_column :expenses, :frequency_weekday, :string
    add_column :chores, :frequency_weekday, :string
  end
end
