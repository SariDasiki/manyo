Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only: [:new, :index, :create, :show, :edit, :update, :destroy]
end

