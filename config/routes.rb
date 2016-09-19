Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  namespace :admin do
    root "static_pages#home"
    resources :users, except: [:edit, :update]
    resources :categories, except: [:destroy]
    resources :words, only: [:index, :new, :create]
    resources :lessons, only: [:index, :show]
    mount Sidekiq::Web, at: "/sidekiq"
  end

  root "static_pages#home"
  resources :users, only: [:index, :show]
  resources :relationships, only: [:index, :create, :destroy]
  resources :words, only: [:index]
  resources :categories, only: [:index, :show]
  resources :lessons, except: [:destroy, :index]
end
