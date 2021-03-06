Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  namespace :api, format: 'json' do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
    resources :tasks, only: [:index, :create, :update, :show]
    resources :users, only: [:index, :create, :update, :destroy, :show]
    resources :departments, only: [:index, :create, :update, :destroy, :show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
