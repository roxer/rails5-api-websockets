Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :diagrams
      resources :canvases
      resources :shapes
    end
  end

  resources :messages
  match "/websocket", :to => ActionCable.server, via: [:get, :post]

  root 'messages#index'
  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html
end
