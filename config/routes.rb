Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :cuisines, only: [:index, :create, :destroy]
      resources :restaurants
      resources :reviews, only: [:create] do
        resources :review_images, only: [:index, :create, :destroy]
      end
      resources :restaurant_cuisines, only: [:create, :show]
      post 'new_review', to: 'new_review#create'
      delete 'restaurant_cuisines', to: 'restaurant_cuisines#destroy'
    end
  end
end
