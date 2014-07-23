FactoryGirl.define do
  factory :user do
    sequence(:first_name)   { |n| "Person #{n}" }
    sequence(:last_name)    { |n| "Person #{n}" }
    sequence(:email)        { |n| "person_#{n}@example.com"}
    password "foobar123"
    password_confirmation "foobar123"
  end
end