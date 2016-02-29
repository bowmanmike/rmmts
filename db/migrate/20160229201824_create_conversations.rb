class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.sender_id :integer
      t.receiver_id :integer

      t.timestamps
    end
  end
end
