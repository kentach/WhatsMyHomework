Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root "static_pages#top"

  resources :homeworks, only: [:index, :show] 
  resources :tasks, only: [:index, :show]
  
  resources :task_completions, only: [:create, :destroy]
end
