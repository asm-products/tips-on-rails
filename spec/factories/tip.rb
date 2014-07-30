FactoryGirl.define do
	factory :tip do
		title "Tip"
    description "Lorem ipsum"
    user
  end

  factory :invalid_tip do
  		title nil
  		description nil
  		user
  	end
end