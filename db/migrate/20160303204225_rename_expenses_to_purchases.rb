class RenameExpensesToPurchases < ActiveRecord::Migration
  def change
    rename_table :expenses, :purchases

    remove_index :payments, :expense_id
    rename_column :payments, :expense_id, :purchase_id
    add_index :payments, :purchase_id
  end
end
