Rails.application.routes.draw do
  get 'home/index'
  root to: "home#index"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :couples, param: :slug do
    resources :events
    resources :goals do
      member do
        patch :mark_as_achieved
      end
    end
  end
end
