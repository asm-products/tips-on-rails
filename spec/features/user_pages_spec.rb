require 'rails_helper'

describe "User pages" do

	before { @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com", 
															password: "foobar123", password_confirmation: "foobar123") }
	subject { page }

	 describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

	describe "profile page" do
		before { visit user_registration_path }
		it { should have_content(@user.full_name) }
	end
end
