Rails.application.routes.draw do
  # Rota GET apenas para visualização (página de login)
  get "auth/login"
  # Rota POST para processamento do login
  post "auth/login", to: "auth#login"

  resources :users
  resources :categories
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
