FactoryGirl.define do
  factory :chore do
    name "Chore Factory"
    due_date { Time.now.next_week.tomorrow }
    frequency_unit "days"
    frequency_integer 1
    complete true
    recurring true
    mate nil
    house

    factory :weekly_chore, class: Chore do
      frequency_unit "weeks"
    end

    factory :monthly_chore, class: Chore do
      frequency_unit "months"
    end

    factory :yearly_chore, class: Chore do
      frequency_unit "years"
    end

    factory :past_due_date_chore, class: Chore do
      due_date { Time.now.yesterday }
    end

    factory :claimed_chore, class: Chore do
      mate
    end

  end
end
