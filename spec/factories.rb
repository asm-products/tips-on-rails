FactoryGirl.define do
  factory :user do
    first_name 'Example'
    last_name  'User'
    email      { "#{first_name}.#{last_name}@example.com".downcase }
    username   { "#{first_name.first.downcase}#{last_name}" }
    password   'foobar123'
    provider   'github'
    uid        '12345'
  end

  factory :tip do
    sequence(:title)  { |n| "Tip title #{n}" }
    description 'Standard tip description'
    body 'Standard tip body'
    user
  end
end
