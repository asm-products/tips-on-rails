require 'rails_helper'

describe 'Static pages' do

	subject { page }

	describe 'Help page' do 
		before { visit help_path }

		it { should have_content('Help') } 
		it { should have_title(full_title('Help')) }
	end

	describe 'About page' do
	before { visit about_path }

		it { should have_content('About') } 
		it { should have_title(full_title('About')) }
	end
end