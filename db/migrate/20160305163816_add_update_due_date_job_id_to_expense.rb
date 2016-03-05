class AddUpdateDueDateJobIdToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :update_due_date_job_id, :integer
  end
end
