class RenameUserIdToMateIdOnMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :user_id, :mate_id
  end
end
