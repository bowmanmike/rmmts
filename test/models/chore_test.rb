require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  setup do
    @chore = create(:chore, complete: true)
    @daily_chore = create(:chore)
    @weekly_chore = create(:weekly_chore)
    @monthly_chore = create(:monthly_chore)
    @yearly_chore = create(:yearly_chore)
  end

  test 'check_status_resets_completion' do
    @chore.check_status
    assert @chore.complete == false
  end

  test 'check_status_update_due_date_daily' do
    due_date = @daily_chore.due_date
    @daily_chore.update_due_date
    assert (due_date + 1.days) == @daily_chore.due_date
  end

  test 'check_status_update_due_date_weekly' do
    due_date = @weekly_chore.due_date
    @weekly_chore.update_due_date
    assert (due_date + 1.weeks) == @weekly_chore.due_date
  end

  test 'check_status_update_due_date_monthly' do
    due_date = @monthly_chore.due_date
    @monthly_chore.update_due_date
    assert (due_date + 1.months) == @monthly_chore.due_date
  end

  test 'check_status_update_due_date_yearly' do
    due_date = @yearly_chore.due_date
    @yearly_chore.update_due_date
    assert (due_date + 1.years) == @yearly_chore.due_date
  end



end
