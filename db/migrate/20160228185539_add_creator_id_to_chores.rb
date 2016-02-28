class AddCreatorIdToChores < ActiveRecord::Migration
  def change
    add_column :chores, :creator_id, :integer, foreign_key: true, index: true
  end
end
