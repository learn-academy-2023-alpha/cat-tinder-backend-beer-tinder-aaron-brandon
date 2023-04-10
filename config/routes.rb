Rails.application.routes.draw do
  resources :liked_beers
  resources :beers
  get '/beers/like/:id', to: 'beers#likeBeer'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
