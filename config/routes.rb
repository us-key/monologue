Rails.application.routes.draw do
  resources :tags
  resources :posts
  resources :users
  root 'application#hello'
end
