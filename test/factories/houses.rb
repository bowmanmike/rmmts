FactoryGirl.define do
  factory :house do
    sequence (:name) { |n| "House#{n}"}

    after(:create) do |house|
      house.mates << create(:mate, house: house)
    end
  end
end
