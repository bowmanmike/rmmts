FactoryGirl.define do
  factory :expense do
    name "MyString"
    description "MyText"
    due_date "2016-02-28 14:23:33"
    amount 1.5
    house nil
  end
end
