Rails.application.routes.draw do
  resources :lift_types
  get 'reports/cards'

resources :lifts do
  collection { post :import }
end

  root 'lifts#index'
end
