class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.belongs_to :mate, index: true, foreign_key: true
      t.belongs_to :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
