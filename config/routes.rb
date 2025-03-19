Rails.application.routes.draw do
  resources :villas, only: [:index] do
    member do
      get :calculate_price
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
