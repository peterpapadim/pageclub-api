Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: "sessions#create"
      get '/search/:term', to: "books#search"
    end
  end
end
