Anifier::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root to: 'dashboard#index'

  resources :users, only: :show

  resources :releasers, only: [:index, :show]

  resources :titles, only: [:index] do
    get :autocomplete_title_name, on: :collection
  end

  resources :subscriptions, only: [] do
    delete :destroy, on: :collection
    post   :create, on: :collection
  end

  namespace :admin do
    resources :releasers, only: [:index, :edit, :update, :destroy]
  end
end
