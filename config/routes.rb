Rails.application.routes.draw do
  root to: 'events#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :events do
  	post '/calendar-add', to: 'users#add_event_to_user', as: 'useradd'
  end
  get '/addresses', to: 'events#addresses'
  get '/today', to: 'events#today'
  get '/users/events', to: 'users#show_events', as: 'show_events'
  get '/user_addresses', to: 'users#addresses'
  get '/users/auth/facebook', as: "login"
  get '/calendar/export', to: 'calendar#export' , as: "export_calendar"
end
