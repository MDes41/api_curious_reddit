Rails.application.routes.draw do
  root 'home#index'
  get '/login', to: 'sessions#new'
  get '/authorize', to: 'sessions#create'
  get '/dashboard', to: 'dashboard#index'
  # get "https://www.reddit.com/api/v1/authorize.compact?client_id=#{ENV['reddit_client_id']}&response_type=code&state=xxx&redirect_uri=http://127.0.0.1:3000&duration=permanent&scope=identity"
end
