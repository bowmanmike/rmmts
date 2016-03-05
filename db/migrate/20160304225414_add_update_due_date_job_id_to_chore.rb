class AddUpdateDueDateJobIdToChore < ActiveRecord::Migration
  def change
    add_column :chores, :update_due_date_job_id, :integer
  end
end
