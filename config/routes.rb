Rails.application.routes.draw do
  namespace :admin do
    resources :homeworks, except: [ :show ]
    resources :classrooms, except: [ :show ]
    resources :notifications, except: [ :show ]

    root "dashboard#index"

    resources :homeworks do
      collection do
        get :draft
        get :published
      end
    end

    resources :notifications do
      collection do
        get :draft
        get :published
      end
    end

    resources :users

    # 管理画面ログイン
    get "login" => "user_sessions#new", :as => :login
    post "login" => "user_sessions#create"
    delete  "logout" => "user_sessions#destroy", :as => :logout
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  root "static_pages#top"

  resources :homeworks, only: [ :index, :show ]
  resources :vocabulary_tests, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :tasks, only: [ :index, :show ] do
    resources :task_completions, only: [ :create, :destroy ] # turboはネストでルーティングを作ること
  end
  resources :notifications, only: [ :index, :show ]
end
