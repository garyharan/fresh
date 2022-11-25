Rails.application.routes.draw do
  resources :profiles do
    resources :images do
      patch :sort, on: :collection
    end
  end

  resources :cards, only: %i[new edit create update destroy]
  resources :users, only: %i[edit update]

  devise_for :users
  get "geo", to: "geo#show"

  root "root#index"
end
