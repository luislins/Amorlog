Rails.application.routes.draw do
  get 'home/index'
  root to: "home#index"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :couples, param: :slug do
    resources :events
  end
end
