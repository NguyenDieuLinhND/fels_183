Rails.application.routes.draw do

  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  namespace :admin do
    root "static_pages#home"
    resources :users, except: [:edit, :update]
    resources :categories, except: [:show, :destroy]
    resources :words, only: [:index, :new, :create]
  end

  root "static_pages#home"
  resources :words, only: [:index]
  resources :categories, only: [:index, :show]
  resources :lessons, except: [:destroy, :index]
end
