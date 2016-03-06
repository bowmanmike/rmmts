class AddImageToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :house_image, :string
  end
end
