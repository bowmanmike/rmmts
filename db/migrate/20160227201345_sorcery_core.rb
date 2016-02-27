class SorceryCore < ActiveRecord::Migration
  def change
    create_table :mates do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.string :first_name
      t.string :last_name
      t.string :username

      t.timestamps
    end

    add_index :mates, :email, unique: true
  end
end
