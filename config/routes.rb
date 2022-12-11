Rails.application.routes.draw do
  resources :profiles do
    resources :images, except: :update do
      patch :sort, on: :collection
    end

    resources :likes, only: %i[create destroy]
  end

  resources :cards, only: %i[new edit create update destroy]

  resources :rooms do
    resources :messages
  end

  resources :groups

  devise_for :users
  get "geo", to: "geo#show"

  root "root#index"
end
