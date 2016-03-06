class AddNotificationPreferencesToMate < ActiveRecord::Migration
  def change
    add_column :mates, :notify_email, :boolean, default: true
    add_column :mates, :notify_sms, :boolean, default: true
  end
end
