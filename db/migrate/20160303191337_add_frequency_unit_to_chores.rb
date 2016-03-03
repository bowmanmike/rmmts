class AddFrequencyUnitToChores < ActiveRecord::Migration
  def change
    rename_column :chores, :frequency, :frequency_integer
    add_column :chores, :frequency_unit, :string
  end
end
