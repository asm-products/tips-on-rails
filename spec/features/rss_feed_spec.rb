require 'rails_helper'

describe "RSS Feed" do
  before do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:tip, title: 'This is the first tip', user: user)
    FactoryGirl.create(:tip, title: 'This is the second tip', user: user)
    FactoryGirl.create(:tip, title: 'This is the third tip', user: user)
  end

  it "displays the latest tips" do
    visit rss_feed_path
    expect(page).to have_selector('item title', text: 'This is the second tip')
    expect(page).to have_selector('item author', text: 'Example User')
  end
end
