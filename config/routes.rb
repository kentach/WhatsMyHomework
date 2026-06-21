Rails.application.routes.draw do
  namespace :admin do
    resources :homeworks
    resources :classrooms
    root "dashboard#index"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  root "static_pages#top"

  resources :homeworks, only: [ :index, :show ]
  resources :vocabulary_tests, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    collection do
      get :score_graph
    end
  end
  resources :tasks, only: [ :index, :show ] do
    resources :task_completions, only: [ :create, :destroy ] # turboはネストでルーティングを作ること
  end
end
