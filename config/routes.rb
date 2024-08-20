Rails.application.routes.draw do
  get 'bottom_pages/agreement'
  get 'bottom_pages/confidentiality'
  get 'bottom_pages/aboutus'
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

  resources :search_results, only: [:show] do
    collection do
      get 'search', to: 'search_results#show'
    end
  end

  get '/404', to: "errors#not_found"

  get '/422', to: "errors#invalid"

  get '/500', to: "errors#internal_server"

  get '/400', to: "errors#bad_request"

  get '/401', to: "errors#unauthorized"

  get '/403', to: "errors#forbidden"

  get '/408', to: "errors#request_timeout"

  get '/429', to: "errors#too_many_requests"

  get '/503', to: "errors#service_unavailable"


  #ТЕСТЫ ОШИБОК
  get 'trigger_500', to: 'errors#trigger_500'
  get 'trigger_422', to: 'errors#invalid'
  get 'trigger_404', to: 'errors#not_found'
  get 'trigger_400', to: 'errors#bad_request'
  get 'trigger_401', to: 'errors#unauthorized'
  get 'trigger_403', to: 'errors#forbidden'
  get 'trigger_408', to: 'errors#request_timeout'
  get 'trigger_429', to: 'errors#too_many_requests'
  get 'trigger_503', to: 'errors#service_unavailable'



  get 'lists/list/show/:id', to: 'lists#show', as: :list_show

  get 'lists/update', to: 'lists#update', as: :list_update

  get 'lists/index', to: 'lists#index', as: :lists_all

  get 'lists/destroy', to: 'lists#destroy', as: :list_destroy

  get '/entries/load_more', to: 'entries#load_more'

  get 'anime/show/:shikimori_id', to: 'anime#show', as: :anime_link

  get 'log_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'

end
