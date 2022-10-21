Rails.application.routes.draw do
  resources :profiles

  get "geo", to: "geo#show"

  devise_for :users

  root "root#index"
end
