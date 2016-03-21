FactoryGirl.define do
  factory :mate do
    sequence (:first_name) { |n| "First#{n}"}
    sequence (:last_name) { |n| "Last#{n}"}
    username "username"
    password "password"
    password_confirmation "password"
    email "username@example.com"
    activation_state "active"
  end
end
