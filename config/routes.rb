Rails.application.routes.draw do
  #resources :friends
  resources :friends do
    get ":friend_account_id", to: "friends#friend_add", on: :new
  end
  resources :profiles
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  
end
