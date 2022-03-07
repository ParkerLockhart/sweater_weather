Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#index'
      get '/backgrounds', to: 'photos#show'
      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#create'
      get '/book-search', to: 'books#index'
    end
  end
end
