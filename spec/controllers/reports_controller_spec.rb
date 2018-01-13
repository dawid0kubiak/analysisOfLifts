require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before (:each) do
    @user = User.create!({
                             email: 'user@test.com',
                             password: 'please',
                             password_confirmation: 'please'
                         })
    sign_in @user
  end
  describe 'GET Index' do
    it "renders the index template" do
      get :all_operation
      expect(response).to render_template("all_operation")
    end
  end
end
