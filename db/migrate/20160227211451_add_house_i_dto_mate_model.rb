class AddHouseIDtoMateModel < ActiveRecord::Migration
  def change
    add_column :mates, :house_id, :integer, foreign_key: true, index: true
  end
end
