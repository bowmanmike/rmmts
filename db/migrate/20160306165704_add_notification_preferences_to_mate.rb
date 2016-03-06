class AddNotificationPreferencesToMate < ActiveRecord::Migration
  def change
    add_column :mates, :notify_email, :boolean
    add_column :mates, :notify_sms, :boolean
  end
end
