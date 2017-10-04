Rails.application.routes.draw do
  resources :photos
  root 'home#landing'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
