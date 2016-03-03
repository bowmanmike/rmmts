class RenameExpensesToPurchases < ActiveRecord::Migration
  def change
    rename_table :expenses, :purchases
  end
end
