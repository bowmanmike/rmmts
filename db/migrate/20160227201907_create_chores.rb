class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :name
      t.text :description
      t.datetime :due_date
      t.integer :frequency
      t.boolean :complete
      t.belongs_to :house, index: true, foreign_key: true
      t.belongs_to :mate, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
