require 'rails_helper'
require 'support/devise_support'

RSpec.describe ReportsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before (:each) do
    sign_in_user
  end
  describe 'GET Index' do
    it "renders the index template" do
      get :all_operation
      expect(response).to render_template("all_operation")
    end
  end
end
