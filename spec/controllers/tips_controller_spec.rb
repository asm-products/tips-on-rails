require 'rails_helper'

describe TipsController do
  let(:current_user) { create(:user) }
  let(:tip) { create(:tip, user: current_user) }

  describe 'GET#index' do
    it 'populates an array of tips' do
      get :index
      expect(assigns(:tips)).to match_array [tip]
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET#show' do
    it 'it assigns the requested tip to @tip' do
      get :show, id: tip
      expect(assigns(:tip)).to eq tip
    end

    it 'renders the :show template' do
      get :show, id: tip
      expect(response).to render_template(:show)
    end
  end

  describe 'GET#new' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:current_user]
      sign_in current_user
    end

    it 'assigns a new Tip to @tip' do
      get :new
      expect(assigns(:tip)).to be_a_new(Tip)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET#edit' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:current_user]
      sign_in current_user
    end

    it 'assigns the requested tip to @tip' do
      get :edit, id: tip
      expect(assigns(:tip)).to eq tip
    end

    it 'renders the :edit template' do
      get :edit, id: tip
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'valid attributes' do
      it 'located the requested @tip' do
        put :update, id: tip, tip: attributes_for(:tip)
        expect(assigns(:tip)).to eq(@tip)
      end
    end
  end
end
