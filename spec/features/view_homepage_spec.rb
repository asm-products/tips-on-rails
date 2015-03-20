require 'rails_helper'

feature 'View the homepage' do
  scenario 'user sees relevant information' do
    visit root_path
    expect(page).to have_title 'Tips on Rails | Home'
  end

  scenario 'Add a new tip' do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    visit new_tip_path
    fill_in 'tip-title', with: 'This is a test tip'
    fill_in 'tip-description', with: 'This is a test description'
    fill_in 'tip_body', with: 'This is a test tip body'
    click_button 'Create Tip'
    expect(page).to have_selector 'h1', text: 'This is a test tip'
  end
end