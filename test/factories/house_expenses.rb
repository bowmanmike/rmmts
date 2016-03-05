FactoryGirl.define do
  factory :house_expense do
    name "MyString"
    description "MyText"
    amount 1.5
    paid false
    due_date "2016-03-04 14:40:15"
    frequency_integer 1
    frequency_unit "MyString"
    recurring false
    house nil
    reminder_id 1
    due_notification_id 1
  end
end
