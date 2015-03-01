FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Fname-#{n}" }
    sequence(:last_name)  { |n| "Lname-#{n}" }
    sequence(:email)      { |n| "person_#{n}@example.com" }
    sequence(:username)   { |n| "user_#{n}" }
    password 'foobar123'
  end
end