Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy] #leaving this here for reference, but since all are here, can just do resources :articles
end