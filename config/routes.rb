Rails.application.routes.draw do
  resources :theaters
  resources :users
  resources :tickets
  resources :show_times
  resources :bookings
  resources :audis
  resources :movies
end