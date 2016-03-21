FactoryGirl.define do
  factory :notification do
    mate
    chore
    email true
    sms true
  end
end
