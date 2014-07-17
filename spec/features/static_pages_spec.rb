require 'rails_helper'

describe 'Static pages' do

	let(:base_title) { "Tips on Rails"}

	describe 'Help page' do 

		it "should have the content 'Help' " do 
			visit '/help'
			expect(page).to have_content('Help')
		end

		it "should have the title 'Help'" do
      visit '/help'
      expect(page).to have_title( "#{base_title} | Help")
    end
	end

	describe 'About page' do

		it "should have the content 'About' " do
			visit '/about'
			expect(page).to have_content('About')
		end

			it "should have the title 'About'" do
      visit '/about'
      expect(page).to have_title("#{base_title} | About")
    end
	end

	describe 'Contact page' do

		it "should have the content 'Contact' " do
			visit '/contact'
			expect(page).to have_content('Contact')
		end

			it "should have the title 'Contact'" do
      visit '/contact'
      expect(page).to have_title("#{base_title} | Contact")
    end
	end
end