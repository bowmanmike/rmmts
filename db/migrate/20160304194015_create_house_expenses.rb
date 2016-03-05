class CreateHouseExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :description
      t.float :amount
      t.boolean :paid
      t.datetime :due_date
      t.integer :frequency_integer
      t.string :frequency_unit
      t.boolean :recurring
      t.belongs_to :house, index: true, foreign_key: true
      t.integer :reminder_id
      t.integer :due_notification_id

      t.timestamps null: false
    end
  end
end
