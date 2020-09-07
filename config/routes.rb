Rails.application.routes.draw do
  get 	 'signup'     => 'users#new'
  get	   'profile'    => 'users#edit'
  put    'profile'    => 'users#update'
  get    'login'      => 'sessions#new'
  post   'login'      => 'sessions#create'
  delete 'logout'     => 'sessions#destroy'
  get    'my_events'  => 'events#user_events'
  resources :users
  resources :events
  resources :sessions
  root 'pages#index'
end
