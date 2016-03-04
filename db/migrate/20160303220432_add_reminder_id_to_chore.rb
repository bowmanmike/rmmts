class AddReminderIdToChore < ActiveRecord::Migration
  def change
    add_column :chores, :reminder_id, :integer
  end
end
