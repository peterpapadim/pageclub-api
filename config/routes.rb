Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :books
      post '/login', to: "sessions#create"
      get '/search/:term', to: "books#search"
      get '/books/id/:term', to: "books#search_by_id"
      get '/users/:id/library', to: "books#library"
    end
  end
end
