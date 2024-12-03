Rails.application.routes.draw do
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

  resources :users, only: :update

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

  resources :public_profiles, only: %i[show]

  resources :cards, only: %i[new edit create update destroy]

  resources :rooms do
    member do
      post :show
    end
    resources :messages
  end

  resources :reads, only: :create

  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
      passwords: "users/passwords"
    }

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      }
      # resource :auth, only: [:create, :destroy]
      # resource :registrations, only: :create
      resources :notification_tokens, only: :create
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
