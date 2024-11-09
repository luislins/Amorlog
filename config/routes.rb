Rails.application.routes.draw do
  root "couples#new" # Define a página inicial como o formulário de criação de casal

  resources :couples, param: :slug do
    resources :events
  end
end
