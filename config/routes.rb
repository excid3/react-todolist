Rails.application.routes.draw do
  devise_for :users
  resources :todos do
    member do
      patch :complete
    end
  end
  root to: "todos#index"
end
