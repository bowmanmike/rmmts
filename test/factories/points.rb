FactoryGirl.define do
  factory :point do
    sequence(:name) { |n| "Points#{n}" }
    amount 1
    completed_date { Time.now.next_week.tomorrow }
    due_date { Time.now.next_week.tomorrow }
    category "Chore"
    mate

  end
end
