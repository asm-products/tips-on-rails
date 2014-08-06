require 'rails_helper'

	describe BookmarksController do
		
		describe "POST#create" do
			it "creates a new bookmark" do
				expect {
					patch :create, bookmark: attributes_for(:bookmark)
				}.to change(Bookmark, :count).by(1)
		end
	end
	describe 'DELETE destroy' do
      it "deletes the bookmark" do
        expect{
          delete :destroy, id: bookmark
        }.to change(Bookmark, :count).by(-1)
      end
    end
  end
