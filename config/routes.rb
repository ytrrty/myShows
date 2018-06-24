Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'devise_override/registrations' }

  root to: 'shows#index'

  resources :shows do
    get :list, on: :collection
    get :change_status, on: :member
    post :to_favorite, on: :member
    resources :comments
  end

  resources :genres

  resources :users do
    get :favorites, on: :member
    get :rates, on: :member
  end

  resources :comments, only: [:create]
  resources :episodes, only: [:new, :show] do
    resources :comments
    post :mark_as_watched, on: :collection
  end

  get :what_to_see, to: 'episodes#what_to_see'
  get :disclaimer, to: 'home#disclaimer'

  post '/rate' => 'rater#create', as: 'rate'
end
