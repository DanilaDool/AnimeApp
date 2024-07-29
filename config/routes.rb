Rails.application.routes.draw do
  get 'search_results/show'

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get 'anime/index'

  get 'anime/cult'

  get 'users/show'

  resources :entries, only: [:create, :update, :destroy] do
    resources :likes, turbo: true, only: [:create, :destroy]
    resources :dislikes, turbo: true, only: [:create, :destroy]
  end

  resources :lists, only: [:create, :update, :index, :destroy] do
    patch 'update_list1', on: :collection
    patch 'update_list2', on: :collection
    patch 'update_list3', on: :collection
  end

  resources :search_results do
    collection do
      get 'search', to: 'search_results#show'
    end
  end

  resources :search_results, only: [:show] do
    collection do
      get 'search', to: 'search_results#show'
    end
  end

  get 'lists/list/show/:id', to: 'lists#show', as: :list_show

  get 'lists/update', to: 'lists#update', as: :list_update

  get 'lists/index', to: 'lists#index', as: :lists_all

  get 'lists/destroy', to: 'lists#destroy', as: :list_destroy

  get '/entries/load_more', to: 'entries#load_more'

  get 'anime/show/:shikimori_id', to: 'anime#show', as: :anime_link

  get 'log_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'

end
