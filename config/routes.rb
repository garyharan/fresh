Rails.application.routes.draw do
  resources :profiles do
    resources :images, except: :update do
      patch :sort, on: :collection
    end
  end

  resources :cards, only: %i[new edit create update destroy]

  devise_for :users
  get "geo", to: "geo#show"

  root "root#index"
end
