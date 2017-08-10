FactoryGirl.define do
  factory :meetup do
    title "Meetup Name"
    description "Description."
  end
  
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    email
    password "password"
    password_confirmation { password }
  end
end