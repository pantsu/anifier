Anifier::Application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :users, only: :show

  resources :releasers, only: [:index, :show]
end
