Rails.application.routes.draw do


  root 'photos#index'

  devise_for :users

  # the only: specifies which routes are going to be create a show page for all users but then controller: :profiles means that if u are the current user u can access the profile routes aspects, edit destroy blah blah.
  resources :users, only: [:show], controller: :profiles
  resource :profile

  resources :photos do
    resources :comments
  end

  get '/feed' => 'feed#index'

end
