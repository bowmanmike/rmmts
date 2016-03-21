FactoryGirl.define do
  factory :chore do
    name "Chore Factory"
    due_date { Time.new.tomorrow }
    frequency_unit "days"
    frequency_integer 1
    # mate
    house

    factory :weekly_chore, class: Chore do
      frequency_unit "weeks"
    end
  end
end
