Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'devise_override/registrations' }

  root to: 'shows#index'
  resources :shows
  resources :genres
  resources :episodes

  resources :users do
    get :favorites, on: :member
    get :rates, on: :member
  end

  resources :comments do
    resources :comments
  end

  resources :shows do
    get :change_status, on: :member
    post :to_favorite, on: :member
    resources :comments
  end

  resources :episodes do
    resources :comments
  end

  post '/rate' => 'rater#create', :as => 'rate'
end
