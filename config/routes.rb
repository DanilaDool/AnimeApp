Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get 'anime/index'

  get 'anime/cult'

  get 'users/show'

  resources :entries, only: [:create, :update, :destroy] do
    resources :likes, turbo: true, only: [:create, :destroy]
    resources :dislikes, turbo: true, only: [:create, :destroy]
  end

  resources :lists, only: [:create, :update, :index]

  get 'lists/list/show/:id', to: 'lists#show', as: :list_show

  get 'lists/index', to: 'lists#index', as: :lists_all

  get '/entries/load_more', to: 'entries#load_more'

  get 'anime/show/:shikimori_id', to: 'anime#show', as: :anime_link

  get 'log_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'

end
