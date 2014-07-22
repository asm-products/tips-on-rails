require 'rails_helper'
require 'shoulda/matchers'

	describe User do
		
		before { @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com", 
															password: "foobar123", password_confirmation: "foobar123") }

		subject { @user }

		it { should respond_to(:first_name) }
		it { should respond_to(:last_name) }
		it { should respond_to(:email) }
		it { should respond_to(:password) }
		it { should respond_to(:password_confirmation) }

		it { should be_valid }

		 describe "when email is not present" do
    	before { @user.email = " " }
    it { should_not be_valid }
  end
end