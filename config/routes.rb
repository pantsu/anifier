Anifier::Application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :users, only: :show

  resources :releasers, only: [:index, :show]

  resources :titles do
    get :autocomplete_title_name, on: :collection
  end

  namespace :admin do
    resources :releasers, only: [:index, :edit, :update, :destroy]
  end
end
