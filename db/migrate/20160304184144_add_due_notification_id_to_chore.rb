class AddDueNotificationIdToChore < ActiveRecord::Migration
  def change
    add_column :chores, :due_notification_id, :integer
  end
end
