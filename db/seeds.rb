User.create(email: 'admin@admin', password: 'zaq12wsx', password_confirmation: 'zaq12wsx')
LiftType.create!(id: -2, name: 'pominięte')
LiftType.create!(id: -1, name: 'inne')
LiftType.create!(user_id: 1, name: 'spożywka', condition: "name like '%KAUFLAND%' or name like '%LIDL%' or name like '%BIEDRONKA%' or name like '%DELIKATESY%' or name like '%POLSKA SIEC HANDLOWA NASZ%'")
LiftType.create!(user_id: 1, name: 'remont', condition: "name like '%MERKURY MARKET%' or name like '%MAJSTER%' or name like '%MROWKA%'")
LiftType.create!(user_id: 1, name: 'kosmetyka', condition: "name like '%ROSSMANN%'")
LiftType.create!(user_id: 1, name: 'paliwo', condition: "name like '%LOTOS%' or name like '%FH TANK%' or name like '%DAREX%' or name like '%RiA%' or name like '%ORLEN%'")
LiftType.create!(user_id: 1, name: 'samochód', condition: "name like '%AUTO-RES%'")
LiftType.create!(user_id: 1, name: 'ubezpieczenie', condition: "name like '%HERSTIA%'")
LiftType.create!(user_id: 1, name: 'zdrowie', condition: "name like '%APTEKA%' or name like '%CEFARM%'")
LiftType.create!(user_id: 1, name: 'mieszkanie', condition: "name like '%SPÓŁDZIELNIA MIESZKANIOWA%'")
LiftType.create!(user_id: 1, name: 'rtv/agd', condition: "name like '%EURO-NET%'")
LiftType.create!(user_id: 1, name: 'bankomat', condition: "transaction_type like '%bankomat%'")
