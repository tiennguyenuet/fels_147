Rails.application.routes.draw do
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "signup" => "users#new"
  get "sessions/new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  namespace :admin do
    resources :users, except: [:create, :new, :show]
    resources :categories
    resources :words
  end
  resources :users
  resources :users do
    member do
      get "/:relationship_type",
      :to => "relationships#index",
      as: "follow"
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :categories
  resources :lessons, except: [:edit, :destroy]
  resources :words, only: :index

end
