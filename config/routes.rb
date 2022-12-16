Rails.application.routes.draw do
  get 'onboarding/zero'
  get 'onboarding/one'
  get 'onboarding/two'
  get 'onboarding/three'
  get 'onboarding/four'

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

  resources :groups do
    resources :memberships, only: %i[new create destroy]
  end

  devise_for :users
  get "geo", to: "geo#show"

  root "root#index"

  get "/:group_id", to: "memberships#new"
end
