Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "projects#index"

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets
  end

  resources :tickets, only: [] do
    resources :comments, only: [:create]
  end

  namespace :admin do
    root 'application#index'

    resources :projects, only: [:new, :create, :destroy]

    resources :users do
      member do
        patch :archive
      end
    end
  end

  resources :attachments, only: [:show]
end
