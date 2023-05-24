Rails.application.routes.draw do

  root "pages#home"
  get "about", to: "pages#about"

  resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy] #leaving this here for reference, but since all are here, can just do resources :articles
  resources :articles do
    member do
      post "index_form"
    end
  end

  get "signup", to: "users#new"
  resources :users, except: [:new]
  resources :users do
    member do
      post "index_form"
    end
  end

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :categories, except: [:destroy]
  
  get "fake_user", to: "faker#user_random_1"
  get "fake_user/:id", to: "faker#user_random"
  get "fake_article", to: "faker#article_random_1"
  get "fake_article/:id", to: "faker#article_random"
  get "fake_category", to: "faker#category_random_1"
  get "fake_category/:id", to: "faker#category_random"
  get "fake_all", to: "faker#set_up_random"

end