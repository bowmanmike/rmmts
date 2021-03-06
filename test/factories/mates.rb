FactoryGirl.define do
  factory :mate do
    sequence(:first_name) { |n| "First#{n}"}
    sequence(:last_name) { |n| "Last#{n}"}
    sequence(:username) { |n| "username#{n}"}
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "username#{n}@example.com" }

    house

    # after(:create) do |mate|
    #   create_list :point, 3, mate: mate, category: "Chore"
    # end
  end
end
