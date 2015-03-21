require 'rails_helper'

describe BookmarksController do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:current_user]
    current_user = create(:user)
    sign_in current_user
  end

  describe 'POST#create' do
    it 'creates a new bookmark in the database' do
      expect do
        post :create, tip_id: 1
      end.to change(Bookmark, :count).by(1)
    end
  end

  describe 'DELETE#destroy' do
    it 'deletes the bookmark from the database' do
      user = create(:user, first_name: 'Another')
      tip = create(:tip, user: user)
      bookmark = user.bookmarks.create(tip_id: tip.id)
      expect do
        delete :destroy, id: bookmark.id
      end.to change(Bookmark, :count).by(-1)
    end
  end
end
