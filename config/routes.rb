Rails.application.routes.draw do
  get 'timelines/index'
  get 'home/index'
  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :couples, param: :slug do
    get 'timeline', to: 'timelines#index', as: 'timeline'
    resources :events
    resources :goals do
      member do
        patch :mark_as_achieved
        patch :update_current_value
      end
    end
  end
end
