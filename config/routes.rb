Rails.application.routes.draw do

  # root 'organizations#show'
  # root 'home#index'
  # root 'organizations#:id'  
  root :to => "organizations#show", :id => '1'

  resources :signed_agreements, only: [:show, :create]
  resources :fee_types
  resources :agreements
  resources :locations
  resources :membership_types
  resources :organizations
  resources :users, only: [:index]
  resources :carriers
  resources :photos, only: :destroy
  resources :categories

  devise_for :users, controllers: { registrations: "users/registrations" }

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
