FactoryGirl.define do
  factory :chore do
    name "MyString"
    description "MyText"
    due_date "2016-02-27 15:19:07"
    frequency 1
    complete false
    house nil
    mate nil
  end
end
