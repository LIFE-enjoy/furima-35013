Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  root to: 'items#index'
  resources :users, only: [:show, :update]
  resources :items do
    resources :orders, only: [:index, :create]
  end
end
