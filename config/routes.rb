Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root 'top#index'

  resources :users, only: [:index, :show] do
    resources :blocks, only: [:create, :destroy]
  end
  get 'users/:id/blocks', to: 'blocks#create'
  get 'users/blocks/:id/destroy', to: 'blocks#destroy'
  
  resources :likes, only: [:create]
  get '/likes', to: 'likes#create'
  get '/users/:id/:reaction', to: 'users#show'

  resources :matching, only: [:index, :new]

  resources :chat_rooms, only: [:create, :show]
  get '/chat_rooms/:user_id/create', to: 'chat_rooms#create'

  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :chat_messages, only: [:create]
  get 'groups_path/:id', to: 'groups#index'
  get 'groups/:id/editInvite', to: 'groups#editInvite'
  get 'groups/:id/editDestroy', to: 'groups#editDestroy'
  get 'groups/:id/destroy', to: 'groups#destroy'

  patch '/editInviteUpdate', to: 'groups#editInviteUpdate'
  patch '/editDestroyUpdate', to: 'groups#editDestroyUpdate'

end
