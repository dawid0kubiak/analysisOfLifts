require 'rails_helper'
# require 'support/devise_support'

RSpec.describe ReportsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before (:each) do
    FactoryGirl.create(:lift_type)
    sign_in_user
  end
  describe 'all_operation' do
    it 'renders the all_operation template' do
      get :all_operation
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('all_operation')
    end
    it 'get all_operation' do
      lift = FactoryGirl.create(:lift)
      get :all_operation
      expect(assigns(:lifts)).to eq([lift])
    end
  end

  describe 'cards' do
    it 'renders the cards template' do
      get :cards
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('cards')
    end

    it 'get all_operation' do
      lift = FactoryGirl.create(:lift)
      get :cards
      expect(assigns(:lifts)).to eq([lift])
    end
  end
end
