Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get 'anime/index'

  get 'users/show'

  resources :entries, only: [:create, :update, :destroy]

  get 'anime/show/:shikimori_id', to: 'anime#show', as: :anime_link

  get 'log_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'

end
