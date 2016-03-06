class AddExpenseIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :expense_id, :integer
    add_index :payments, :expense_id
  end
end
