class AddPhoneNumberToMate < ActiveRecord::Migration
  def change
    add_column :mates, :phone_number, :integer
  end
end
