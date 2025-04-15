Rails.application.routes.draw do
  get "profile/show"
  resource :session
  resources :passwords, param: :token

  resources :users, only: [:new, :create, :update]

  resources :partnerships
  namespace :admin do
    resources :profiles
  end

  resources :settings, only: [:index, :update]
  namespace :settings do
    get :public
    post :toggle_public

    get :invite
    get :notifications

    get :distance
    get :orientation

    get :partnerships
  end

  get "onboarding/one"
  get 'dashboard/index'

  patch "onboarding/update_one"
  get "onboarding/two"
  patch "onboarding/update_two"
  get "onboarding/three"
  get "onboarding/four"
  get "onboarding/finish"

  resources :recommendations do
    member do
      post :like
      post :pass
    end
  end

  resources :profiles do
    resources :images, except: :update do
      patch :sort, on: :collection
    end

    collection do
      get :passed
    end

    resources :likes, only: %i[create destroy]
    resources :passes, only: %i[create destroy]
  end
  get 'profile', to: 'profile#show'

  resources :public_profiles, only: %i[show]

  resources :cards

  resources :rooms do
    member do
      post :show
      get :request_more
    end
    resources :messages
  end

  resources :reads, only: :create

  resources :configurations, only: [] do
    get :ios_v1, on: :collection
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :notification_tokens, only: :create

      resource :profile do
        get :status
      end
    end
  end

  namespace :turbo do
    namespace :ios do
      resource :path_configuration, only: :show
    end
    namespace :android do
      resource :path_configuration, only: :show
    end
  end

  get "geo", to: "geo#show"

  root "root#index"

  get 'dashboard', to: 'dashboard#index'

  get "/invitation/:invite_code", to: "invitations#save"
end
