FactoryGirl.define do
  factory :tip do
    sequence(:title)  { |n| "Tip title #{n}" }
    description 'Standard tip description'
    body 'Standard tip body'
    user
  end
end
