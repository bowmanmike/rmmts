class AddRememberMeTokenToMates < ActiveRecord::Migration
  def self.up
    add_column :mates, :remember_me_token, :string, :default => nil
    add_column :mates, :remember_me_token_expires_at, :datetime, :default => nil

    add_index :mates, :remember_me_token
  end

  def self.down
    remove_index :mates, :remember_me_token

    remove_column :mates, :remember_me_token_expires_at
    remove_column :mates, :remember_me_token
  end
end
