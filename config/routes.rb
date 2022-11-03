Rails.application.routes.draw do
  resources :profiles do
    member do
      get :edit_age
      get :edit_relationship_style
    end
    resources :images
  end

  get "geo", to: "geo#show"

  devise_for :users

  root "root#index"
end
