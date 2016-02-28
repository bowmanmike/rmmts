class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :amount
      t.datetime :paid_date
      t.belongs_to :mate, index: true, foreign_key: true
      t.belongs_to :expense, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
