require 'rails_helper'

describe "User pages" do

	subject { page }

	 describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

	describe "profile page" do
		let(:user) { FactoryGirl.build(:user)}
		before { visit user_path(user) }

		it { should have_content(user.name) }
	end
end
