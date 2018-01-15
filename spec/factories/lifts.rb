FactoryGirl.define do
  factory :lift do
    date_of_booking '2018-01-05'
    date_of_commissioned '2018-01-05'
    transaction_type 'Płatność kartą'
    amount -123
    name 'LIDL SIKORSKIEGO Tarnobrzeg POLSKA'
    lift_type_id 1
    user_id 1
    created_at '2018-01-15 11:24:11'
    updated_at '2018-01-15 11:24:11'
  end
end