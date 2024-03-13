Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  namespace :admin do
    resources :users, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  end
  # 再度確認
  resources :sessions, only: [:new, :create, :destroy]
end

