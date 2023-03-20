Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "reservations#index"

  get "/calendar", to: "calendar#index"
  patch "/calendar", to: "calendar#update"

  post '/confirm_reservation', to: 'reservations#confirm'
  post '/decline_reservation', to: 'reservations#decline'

  resources :reservations, only: [:new, :create]
end
