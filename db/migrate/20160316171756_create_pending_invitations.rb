class CreatePendingInvitations < ActiveRecord::Migration
  def change
    create_table :pending_invitations do |t|
      t.belongs_to :mate, index: true, foreign_key: true
      t.belongs_to :house, index: true, foreign_key: true
      t.boolean :accepted, default: false

      t.timestamps null: false
    end
  end
end
