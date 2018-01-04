Rails.application.routes.draw do
  resources :lift_types
  get 'reports/cards'

resources :lifts, only: :index do
  collection { post :import }
  collection { get :set_type }
end

  root 'lifts#index'
end
