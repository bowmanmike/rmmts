class AddAvatarToMates < ActiveRecord::Migration
  def change
    add_column :mates, :mate_avatar, :string
  end
end
