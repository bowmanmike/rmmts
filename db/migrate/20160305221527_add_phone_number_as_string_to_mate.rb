class AddPhoneNumberAsStringToMate < ActiveRecord::Migration
  def change
    add_column :mates, :phone_number, :string
  end
end
