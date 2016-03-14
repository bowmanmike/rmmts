class SorceryUserActivation < ActiveRecord::Migration
  def self.up
  add_column :mates, :activation_state, :string, :default => nil
  add_column :mates, :activation_token, :string, :default => nil
  add_column :mates, :activation_token_expires_at, :datetime, :default => nil

  add_index :mates, :activation_token
end

def self.down
  remove_index :mates, :activation_token

  remove_column :mates, :activation_token_expires_at
  remove_column :mates, :activation_token
  remove_column :mates, :activation_state
end
end
