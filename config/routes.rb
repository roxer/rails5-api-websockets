Rails.application.routes.draw do
  resources :events do
    resources :menus
  end
  resources :venues do
    resources :menus
  end
  resources :places do
    resources :menus
  end
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :diagrams
      resources :canvases
      resources :shapes
    end
  end

  resources :messages
  resources :data_files

  resources :uploads do
    # collection do
    #   post 'upload'
    # end
  end
  # match "/websocket", :to => ActionCable.server, via: [:get, :post]
  mount ActionCable.server => "/websocket"

  root 'messages#index'

  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html
end
