Rails.application.routes.draw do
  resources :profiles do
    resources :images
  end

  get "geo", to: "geo#show"

  devise_for :users

  root "root#index"
end
