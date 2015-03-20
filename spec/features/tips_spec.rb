require 'rails_helper'

feature 'User works with tips' do
  let(:user) { user = FactoryGirl.create(:user) }

  scenario 'adds a new tip' do
    login_as(user, scope: :user)
    visit new_tip_path
    fill_in 'tip-title', with: 'This is a test tip'
    fill_in 'tip-description', with: 'This is a test description'
    fill_in 'tip_body', with: 'This is a test tip body'
    click_button 'Create Tip'
    expect(page).to have_selector 'h1', text: 'This is a test tip'
  end
end
