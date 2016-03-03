require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  setup do
    @daily = FactoryGirl.create(:daily_chore)
    @weekly = FactoryGirl.create(:weekly_chore)
    @monthly = FactoryGirl.create(:monthly_chore)
    @odd_time = FactoryGirl.create(:odd_time_chore)
  end

  test "daily_chore_update_due_date" do
    @daily.update_due_date
    assert @daily.due_date == "2016-03-28"
  end

  test "weekly_chore_update_due_date" do
    @weekly.update_due_date
    assert @weekly.due_date == "2016-04-03"
  end

  test "monthly_chore_update_due_date" do
    @monthly.update_due_date
    assert @monthly.due_date == "2016-04-27"
  end

  test "odd_time_update_due_date" do
    @odd_time.update_due_date
    assert @odd_time.due_date == "2016-04-16"
  end

end
