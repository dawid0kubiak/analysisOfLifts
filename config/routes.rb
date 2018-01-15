Rails.application.routes.draw do
  devise_for :users
  resources :lift_types
  get 'reports/all_operation'
  post 'reports/all_operation'
  get 'reports/cards'
  get 'reports/add_form'
  get 'reports/sub_form'

  resources :lifts, only: :index do
    collection {post :import}
    collection {get :set_type}
  end

  root 'lifts#index'
end
