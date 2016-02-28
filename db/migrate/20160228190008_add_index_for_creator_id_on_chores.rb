class AddIndexForCreatorIdOnChores < ActiveRecord::Migration
  def change
    add_index :chores, :creator_id
  end
end
