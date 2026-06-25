Rails.application.routes.draw do
  namespace :admin do
    resources :homeworks, except: [ :show ]
    resources :classrooms, except: [ :show ]
    resources :notifications, except: [ :show ]

    root "dashboard#index"
    get "/homeworks/draft", to: "homeworks#draft", as: :draft_homeworks
    get "/homeworks/published", to: "homeworks#published", as: :published_homeworks
    get "/notifications/draft", to: "notifications#draft", as: :draft_notifications
    get "/notifications/published", to: "notifications#published", as: :published_notifications
    resources :users

    # 管理画面ログイン
    get "login" => "user_sessions#new", :as => :login
    post "login" => "user_sessions#create"
    get  "logout" => "user_sessions#destroy", :as => :logout
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
