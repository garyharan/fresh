Rails.application.routes.draw do
  resources :profiles
  resources :images

  get "geo", to: "geo#show"

  devise_for :users

  root "root#index"
end
