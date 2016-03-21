FactoryGirl.define do
  factory :house do
    sequence (:name) { |n| "House#{n}"}
  end
end
