require 'rails_helper'

	describe BookmarksController do
		
		describe "POST#create" do
			it "creates a new bookmark" do
				expect {
					post :create, bookmark: attributes_for(:bookmark)
				}.to change(Bookmark, :count).by(1)
		end
	end
	describe 'DELETE destroy' do
      it "deletes the bookmark" do
        expect{
          delete :destroy, id: bookmark
        }.to change(Bookmark, :count).by(-1)
      end

      it "redirects to contacts#index" do
        delete :destroy, id: Bookmark
        expect(response).to redirect_to tip_path(bookmarks.tip)
      end
    end
  end
