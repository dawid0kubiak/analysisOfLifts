FactoryBot.define do
  factory :user do
    email 'user@user.com'
    password 'user123'
    password_confirmation 'user123'
  end
end