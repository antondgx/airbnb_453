Rails.application.routes.draw do
  devise_for :users
  root to: 'properties#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :properties do
    resources :bookings, only:[:new, :create]
    resources :reviews
  end
  resources :bookings, only:[:destroy]
  resources :orders, only: [:show, :create] do 
      resources :payments, only: :new
  end
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  

  get "/bookings", to: "bookings#my_bookings", as: :my_bookings

  get "/myproperties/bookings", to: "bookings#bookings_on_my_properties", as: :bookings_on_my_properties

end
