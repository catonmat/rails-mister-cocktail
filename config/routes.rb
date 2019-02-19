Rails.application.routes.draw do
  root to: 'cocktails#index'

  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cocktails, only: [:index, :new, :update, :show, :create] do
    resources :doses, only: [:new, :create]
  end

  resources :doses, only: [:destroy]

end
