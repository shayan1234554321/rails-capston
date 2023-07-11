Rails.application.routes.draw do
  devise_for :users
  
  root to: 'groups#index'

  resources :groups, only: [:index, :create] do
    resources :entities, only: [:index, :create]
  end
end
