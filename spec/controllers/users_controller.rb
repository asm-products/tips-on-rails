require 'rails_helper'

describe UsersController do
		

	describe "GET #show" do
		it "it asigns the requested user to @user" do
			user = create(:user)
			get :show, id: user
			expect(assigns(:user)).to eq user
		end
		it "renders the :show template" do
			user = create(:user)
			get :show, id: user
			expect(response).to render_template :show
		end
	end
end