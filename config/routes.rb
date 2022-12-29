Rails.application.routes.draw do
  get "onboarding/one"
  patch "onboarding/update_one"

  get "onboarding/two"
  patch "onboarding/update_two"
  get "onboarding/three"
  get "onboarding/four"

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

    resources :likes, only: %i[create destroy]
    resources :passes, only: %i[create destroy]
  end

  resources :cards, only: %i[new edit create update destroy]

  resources :rooms do
    member { get "unread" }
    resources :messages
  end

  resources :groups do
    resources :memberships
  end

  devise_for :users,
             controllers: {
               registrations: "users/registrations",
               sessions: "users/sessions",
               passwords: "users/passwords"
             }

  get "geo", to: "geo#show"

  root "root#index"

  get "/:group_slug", to: "memberships#new"
end
