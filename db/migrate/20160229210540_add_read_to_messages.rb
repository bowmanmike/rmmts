class AddReadToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read, :boolean, :default => false
    remove_column :conversations, :read
  end
end
