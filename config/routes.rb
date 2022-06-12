Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :game, only: [:new, :create]
  # Defines the root path route ("/")
  root "games#new"
end
