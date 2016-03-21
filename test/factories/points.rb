FactoryGirl.define do
  factory :point do
    name "Points"
    amount 1
    completed_date { Time.now.next_week }
    due_date { Time.now.next_week.tomorrow }
    category "MyString"
    mate
  end
end
