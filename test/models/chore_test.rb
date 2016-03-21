require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  setup do
    @chore = create(:chore, complete: true)
    @daily_chore = create(:chore, complete: true)
  end

  test 'check_status_resets_completion' do
    @chore.check_status
    assert @chore.complete == false
  end

  test 'check_status_update_due_date_daily' do
    @due_date = @daily_chore.due_date
    @daily_chore.update_due_date
    assert (@due_date + 1.days) == @daily_chore.due_date
  end


  # setup do
  #   @daily = FactoryGirl.create(:daily_chore)
  #   @weekly = FactoryGirl.create(:weekly_chore)
  #   @monthly = FactoryGirl.create(:monthly_chore)
  #   @odd_time = FactoryGirl.create(:odd_time_chore)
  #   @one_time = FactoryGirl.create(:one_time_chore)
  # end
  #
  # test "daily_chore_update_due_date" do
  #   @daily.update_due_date
  #   assert @daily.due_date == "2016-03-28"
  # end
  #
  # test "weekly_chore_update_due_date" do
  #   @weekly.update_due_date
  #   assert @weekly.due_date == "2016-04-03"
  # end
  #
  # test "monthly_chore_update_due_date" do
  #   @monthly.update_due_date
  #   assert @monthly.due_date == "2016-04-27"
  # end
  #
  # test "odd_time_update_due_date" do
  #   @odd_time.update_due_date
  #   assert @odd_time.due_date == "2016-04-16"
  # end
  #
  # test "check_status_on_one_time_chore" do
  #   @one_time.check_status
  #   assert @one_time.complete? && @one_time.due_date == "2016-03-27"
  # end
  #
  # test "check_status_on_recurring_chore" do
  #   @daily.check_status
  #   assert !@daily.complete? && @daily.due_date == "2016-03-28"
  # end
  #
end
