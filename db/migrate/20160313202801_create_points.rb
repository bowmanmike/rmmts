class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :name
      t.integer :amount
      t.datetime :completed_date
      t.datetime :due_date
      t.string :category
      t.integer :category_id # No association with another table; merely for record-keeping
      t.belongs_to :mate, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
