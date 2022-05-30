Rails.application.routes.draw do
  root 'home#top'
  get 'terms', to: 'home#terms'
  get 'privacy', to: 'home#privacy'
  get 'about', to: 'home#about'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_scope :admin do
    get 'dashboard', to: 'dashboard#index'
    get 'dashboard/login', to: 'admins/sessions#new'
    post 'dashboard/login', to: 'admins/sessions#create'
    delete 'dashboard/logout', to: 'admins/sessions#destroy'
  end

  namespace :dashboard do
    resources :users, only: %i[index show destroy]
    resources :items, except: [:show]
    resources :reservations,only: %i[index show edit update destroy]
    resources :contacts, only: %i[index show update]
    patch '/reservations/cancel/:id', to: 'reservations#cancel'
    get '/calendar', to: 'reservations#reservation_calendar'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }

  devise_scope :user do
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    delete 'logout', to: 'users/sessions#destroy'
  end

  resource :users, only: [:show] do
    collection do
      # マイページ
      get 'mypage', to: 'users#mypage'
      # パスワード
      get 'mypage/edit_password', to: 'users#edit_password'
      put 'mypage/password', to: 'users#update_password'
    end
  end
  resources :reservations, only: %i[new create]
  resources :contacts, only: %i[index create]
end
