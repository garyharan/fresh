Rails.application.routes.draw do
  get 'legal/privacy'
  get 'legal/terms'

  get 'general/about'
  get 'profile/show'
  resource :session
  resources :passwords, param: :token

  resources :notification_tokens, only: :create

  resources :users, only: %i[new show create update destroy]

  resources :partnerships, only: %i[create destroy]
  namespace :admin do
    resources :profiles
  end

  resources :events do
    resources :attendances, only: %i[create update destroy]
    member do
      get :calendar
    end
  end

  resources :settings, only: %i[index update]
  namespace :settings do
    get :invite

    get :distance
    get :orientation
  end

  get 'onboarding/one'
  get 'dashboard/index'

  patch 'onboarding/update_one'
  get 'onboarding/two'
  patch 'onboarding/update_two'
  get 'onboarding/three'
  get 'onboarding/four'
  get 'onboarding/finish'

  resources :profiles do
    resources :images, except: :update do
      patch :sort, on: :collection
    end

    resources :assessments, only: :create
  end
  get 'profile', to: 'profile#show'

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
    get :android_v1, on: :collection
  end

  namespace :api, defaults: { format: :json } do
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

  get 'geo', to: 'geo#show'

  root 'root#index'

  get '/about', to: 'general#about'

  get 'dashboard', to: 'dashboard#index'

  get '/invitation/:invite_code', to: 'invitations#save'
end
