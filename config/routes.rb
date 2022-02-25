Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index create new show] do
      resources :comment, only: %i[create]
      resources :like, only: %i[create]
    end
  end
  root to: 'users#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
