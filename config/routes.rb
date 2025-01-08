Rails.application.routes.draw do
  get 'timelines/index'
  get 'home/index'
  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :couples, param: :slug do
    get 'timeline', to: 'timelines#index', as: 'timeline'
    resource :savings_table, only: [:show, :update]
    resources :events do
      member do
      delete :destroy_image
      end
    end
    resources :goals do
      member do
        patch :mark_as_achieved
        delete :destroy_image
      end
    end
  end

  resources :savings_table_squares, only: [] do
    member do
      patch :toggle_checked
    end
  end
end
