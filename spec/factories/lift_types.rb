FactoryBot.define do
  factory :lift_type, class: LiftType do
    id 1
    name 'spożywka'
    condition "name like '%KAUFLAND%' or name like '%LIDL%' or name like '%BIEDRONKA%' or name like '%DELIKATESY%' or name like '%POLSKA SIEC HANDLOWA NASZ%'"
    user_id 1
  end
end