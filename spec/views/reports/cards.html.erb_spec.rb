require 'rails_helper'

RSpec.describe 'reports/cards', type: :view do
  include Devise::Test::ControllerHelpers

  before (:each) do
    FactoryGirl.create(:lift_type)
    sign_in_user
  end
  it 'display lifts correctly' do
    FactoryGirl.create(:lift)
    assign(:lifts, Lift.all)

    assign(:chart_data, size: {height: 400, width: 600},
           name: '"[{"value":"14.9","label":"PAYU S.A  UL. GRUNWALDZKA 182 60-166 POZNAŃ (100.0 %) "}]"',
           type: '"[{"value":"14.9","label":"inne (100.0 %) "}]"')
    render

    expect(rendered).to match('LIDL SIKORSKIEGO Tarnobrzeg POLSKA')
  end
end
