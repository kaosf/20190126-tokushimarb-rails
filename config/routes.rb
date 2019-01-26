Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resource :two_factor_auth, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
