Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root "static_pages#home"
    resources :users, only: [:index, :new, :create]
    resources :categories, except: [:show, :destroy]
  end

  root "static_pages#home"
end
