require 'rails_helper'

feature 'Visiting static content pages' do
  scenario 'user can read Help page content' do 
    visit help_path
    expect(page).to have_title full_title('Help')
    expect(page).to have_selector 'h2', text: 'Help with Posting Tips'
  end

  scenario 'user can read About page content' do
    visit about_path
    expect(page).to have_selector 'h2', text: 'About Tips on Rails'
    expect(page).to have_title full_title('About')
  end
end
