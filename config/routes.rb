Rails.application.routes.draw do
  root to: 'events#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :events do
  	post '/calendar-add', to: 'visitors#add_event_to_user', as: 'useradd'
  end
  get '/addresses', to: 'events#addresses'
  get '/today', to: 'events#today'
end
