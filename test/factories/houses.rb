FactoryGirl.define do
  factory :house do
    sequence (:name) { |n| "House#{n}"}

    after(:create) do |house|
      4.times { house.mates << create(:mate, house: house) }
    end
  end
end
