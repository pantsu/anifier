Anifier::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  root to: 'dashboard#index'

  resources :users, only: :show

  resources :releasers, only: [:index, :show]

  resources :titles, only: [] do
    get :autocomplete_title_name, on: :collection
  end

  namespace :admin do
    resources :releasers, only: [:index, :edit, :update, :destroy]
  end
end
