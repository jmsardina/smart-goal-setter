Rails.application.routes.draw do
  resources :search
  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks", sessions: 'users/sessions', registrations: "users/registrations"  }

  root to: 'goals#index'

  get 'welcome/index' => 'welcome#index'

  resources :goals do
    resources :activities
  end
end
