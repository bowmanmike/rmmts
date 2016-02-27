class AddCreatorIdToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :creator_id, :integer
    add_index :houses, :creator_id
  end
end
