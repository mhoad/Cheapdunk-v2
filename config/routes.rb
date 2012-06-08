Cheapdrunk::Application.routes.draw do

  resources :venues do
    resources :reviews, :only => [:create, :destroy]
  end

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:show, :index]

  match '/terms', to: 'home#terms_of_use'
end
