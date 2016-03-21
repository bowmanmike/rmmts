require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  setup do
    # @chore = create(:chore, complete: true)
    @daily_chore = create(:chore)
    @weekly_chore = create(:weekly_chore)
    @monthly_chore = create(:monthly_chore)
    @yearly_chore = create(:yearly_chore)
    # @past_chore = create(:past_due_date_chore)
  end

  test 'check_status_resets_completion' do
    chore = create(:chore).check_status
    assert chore.complete? == false
  end

  test 'check_status_update_due_date_daily' do
    skip
    due_date = @daily_chore.due_date
    @daily_chore.update_due_date
    assert (due_date + 1.days) == @daily_chore.due_date
  end

  test 'check_status_update_due_date_weekly' do
    skip
    due_date = @weekly_chore.due_date
    @weekly_chore.update_due_date
    assert (due_date + 1.weeks) == @weekly_chore.due_date
  end

  test 'check_status_update_due_date_monthly' do
    skip
    due_date = @monthly_chore.due_date
    @monthly_chore.update_due_date
    assert (due_date + 1.months) == @monthly_chore.due_date
  end

  test 'check_status_update_due_date_yearly' do
    skip
    due_date = @yearly_chore.due_date
    @yearly_chore.update_due_date
    assert (due_date + 1.years) == @yearly_chore.due_date
  end

  # test 'due_date_cannot_be_in_the_past' do
  #   assert_false @past_chore
  # end

end
