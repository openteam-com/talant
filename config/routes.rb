Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    resources :proposals, only: [:index, :destroy]
    resources :events
    resources :participants
    root to: 'events#index'
  end

  resources :events, only: [:index] do
    post 'send_event', as: :send, on: :collection
  end

  resources :proposals,     only: [:new, :create]
  resources :participants,  only: [:index]

  get 'about',            as: :about, to: 'static_pages#about'
  get 'show_conditions',  as: :show_conditions, to: 'static_pages#show_conditions'

  root to: 'events#index'
end
