Rails.application.routes.draw do
  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks", sessions: 'users/sessions', registrations: "users/registrations"  }

  root 'goals#index'

  resources :goals do
    resources :activities
  end
end
