class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :description
      t.datetime :due_date
      t.float :amount
      t.belongs_to :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
