FactoryGirl.define do
	factory :tip do
		title "Tip" 
		body "some things"
		description "Lorem ipsum" 
		user_id 1
		slug "tip-by-example"
    user
  end
end