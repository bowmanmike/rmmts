FactoryGirl.define do
  factory :point do
    sequence(:name) { |n| "Points#{n}" }
    amount 1
    completed_date { Time.now.next_week }
    due_date { Time.now.next_week.tomorrow }
    category "MyString"
    mate
  end
end
