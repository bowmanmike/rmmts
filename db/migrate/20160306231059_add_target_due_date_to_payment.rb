class AddTargetDueDateToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :target_due_date, :datetime
  end
end
