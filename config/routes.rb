Rails.application.routes.draw do
  resources :news
  #resources :friends
  resources :friends, :only => [:index, :show, :new, :destroy] do
    get ":friend_account_id", to: "friends#friend_add", on: :new
  end
  resources :profiles, :only => [:index, :show, :new, :create, :edit, :update] do
  end
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  
end
