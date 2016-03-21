FactoryGirl.define do
  factory :chore do
    name "Chore Factory"
    due_date { Time.now.next_week }
    frequency_unit "days"
    frequency_integer 1
    mate
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

  end
end
