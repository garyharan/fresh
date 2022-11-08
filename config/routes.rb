Rails.application.routes.draw do
  resources :profiles do
    resources :images do
      patch :sort, on: :collection
    end
  end

  get "geo", to: "geo#show"

  devise_for :users

  resources :settings

  root "root#index"
end
