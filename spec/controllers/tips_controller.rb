require 'rails_helper'

describe TipsController do
	let(:tip) do
		create(:tip, title: "Tip", description: "Lorem Epsum")
	end

		describe 'GET #index' do
			it "populates an array of tips" do
				get :index
				expect(assigns(:tips)).to match_array [tip]
			end

			it "renders the :index view" do
				get :index
				expect(response).to render_template :index
			end
		end

		describe 'GET #show' do
			it "it assigns the requested tip to @tip" do
				get :show, id: tip
				expect(assigns(:tip)).to eq tip
			end

		it "renders the :show template" do
			get :show, id: tip
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		it "assigns a new Tip to @tip" do
			get :new
			expect(assigns(:tip)).to be_a_new(Tip)
		end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do
		it 'assigns the requested tip to @tip' do
			tip = Tip.new
			get :edit, id: tip
			expect(assigns(:tip)).to eq tip
		end

		it "renders the :edit template" do
			get :edit, id: tip
			expect(response).to render_template :edit
		end
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "creates a new tip" do
				expect{
					post :create, tip: attributes_for(:tip)
				}.to change(Tip,:count).by(1)
			end

			it "redirects to the new tip" do
				post :create, tip: attributes_for(:tip)
				expect(response).to redirect_to Tip.last
			end
		end

		context "with invalid attributes" do
			it "does not save the tip" do
				expect {
					post :create, tip: attributes_for(:invalid_tip)
				}.to_not change(Tip,:count)
			end

			it "re-renders the new method" do
				post :create, tip: attributes_for(:invalid_tip)
				expect(reponse).to render_template :new
			end
		end
	end

	describe 'PUT #update' do
		context "valid attributes" do
			it "located the requested @tip" do
				put :update, id: tip, tip: attributes_for(:tip)
				expect(assigns(:tip)).to eq(tip)
			end
		end
	end
end



