require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  setup do
  end

  test 'check_status_ignores_non_recurring_chore' do
    chore = build(:chore, recurring: false)
    due_date = chore.due_date
    chore.check_status
    assert chore.due_date == due_date
  end

  test 'check_status_resets_completion' do
    chore = create(:chore)
    chore.check_status
    assert chore.complete? == false
  end

  test 'check_status_update_due_date_daily' do
    daily_chore = create(:chore)
    due_date = daily_chore.due_date
    daily_chore.update_due_date
    assert (due_date + 1.days) == daily_chore.due_date
  end

  test 'check_status_update_due_date_weekly' do
    weekly_chore = create(:weekly_chore)
    due_date = weekly_chore.due_date
    weekly_chore.update_due_date
    assert (due_date + 1.weeks) == weekly_chore.due_date
  end

  test 'check_status_update_due_date_monthly' do
    monthly_chore = create(:monthly_chore)
    due_date = monthly_chore.due_date
    monthly_chore.update_due_date
    assert (due_date + 1.months) == monthly_chore.due_date
  end

  test 'check_status_update_due_date_yearly' do
    yearly_chore = create(:yearly_chore)
    due_date = yearly_chore.due_date
    yearly_chore.update_due_date
    assert (due_date + 1.years) == yearly_chore.due_date
  end

  test 'due_date_cannot_be_in_the_past' do
    past_chore = build(:past_due_date_chore)
    assert past_chore.save == false
  end

  test 'create_notifications_for_chore' do
    chore = create(:chore)
    chore.create_notifications
    assert chore.notifications.size > 0
  end

  test ''

end
