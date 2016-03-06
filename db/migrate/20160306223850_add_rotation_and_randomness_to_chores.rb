class AddRotationAndRandomnessToChores < ActiveRecord::Migration
  def change
    add_column :chores, :reassignment_style, :string, default: "claimable"
  end
end
