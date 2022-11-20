Rails.application.routes.draw do
  get "users/update"
  resources :profiles do
    resources :images do
      patch :sort, on: :collection
    end
  end

  get "geo", to: "geo#show"

  resources :users, only: %i[edit update]

  devise_for :users

  root "root#index"
end
