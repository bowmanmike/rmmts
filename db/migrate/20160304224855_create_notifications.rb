class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :mate, index: true, foreign_key: true
      t.references :chore, index: true, foreign_key: true
      t.boolean :email
      t.boolean :sms

      t.timestamps null: false
    end
  end
end
