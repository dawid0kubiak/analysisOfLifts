Rails.application.routes.draw do
  devise_for :users
  resources :lift_types
  get 'reports/cards'
  get 'reports/all_operation'

resources :lifts, only: :index do
  collection { post :import }
  collection { get :set_type }
end

  root 'lifts#index'
end
