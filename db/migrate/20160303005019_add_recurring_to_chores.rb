class AddRecurringToChores < ActiveRecord::Migration
  def change
    add_column :chores, :recurring, :boolean, default: true
  end
end
