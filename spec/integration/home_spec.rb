require 'spec_helper'

describe 'home page' do
  before (:each) do
    FactoryBot.create(:lift_type)
    FactoryBot.create(:user)
  end
  it 'welcomes the user', js: true do
    visit '/'
fill_in 'Adres e-mail', with: 'user@user.com'
fill_in 'Hasło', with: 'user123'
click_on 'Zaloguj się'
click_on 'Plik wyciągu'
    expect have_content('Plik wyciągu')
  end
end