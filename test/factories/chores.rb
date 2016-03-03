FactoryGirl.define do
  factory :daily_chore, class: "Chore"  do
    name "Daily Chore"
    due_date "2016-03-27"
    frequency_unit "days"
    frequency_integer 1
    complete true
    recurring true
  end

  factory :weekly_chore, class: "Chore" do
    name "Weekly Chore"
    due_date "2016-03-27"
    frequency_unit "weeks"
    frequency_integer 1
  end

  factory :monthly_chore, class: "Chore" do
    name "Monthly Chore"
    due_date "2016-03-27"
    frequency_unit "months"
    frequency_integer 1
  end

  factory :odd_time_chore, class: "Chore" do
    name "Non-Standard Time Chore"
    due_date "2016-03-27"
    frequency_unit "days"
    frequency_integer "20"
  end

  factory :one_time_chore, class: "Chore" do
    name "One-Time Chore"
    due_date "2016-03-27"
    frequency_unit "days"
    frequency_integer 1
    recurring false
    complete true
  end
end
