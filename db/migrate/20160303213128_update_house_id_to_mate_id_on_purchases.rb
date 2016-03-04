class UpdateHouseIdToMateIdOnPurchases < ActiveRecord::Migration
  def change
    remove_index :purchases, :house_id
    remove_column :purchases, :house_id

    add_column :purchases, :mate_id, :integer, foreign_key: true, index: true
    add_index :purchases, :mate_id
  end
end
