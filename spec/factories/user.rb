FactoryGirl.define do
  factory :user do
    first_name 'Example'
    last_name  'User'
    email      'user@example.com'
    username   'username'
    password   'foobar123'
    provider   'github'
    uid        '12345'
  end
end
