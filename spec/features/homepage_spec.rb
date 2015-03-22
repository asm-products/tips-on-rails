require 'rails_helper'

feature 'User visits the homepage' do
  let(:user) { create(:user) }

  scenario 'as a guest user' do
    visit root_path
    expect(page).to have_selector 'a.btn', text: 'Sign in with GitHub'
  end

  scenario 'as a signed in user' do
    login_as(user, scope: :user)
    visit root_path
    expect(page).not_to have_selector 'a.btn', text: 'Sign in with GitHub'
  end
end
