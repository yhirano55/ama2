Rails.application.routes.draw do
  get "/auth/github/callback" => "authentications#create"

  resources :users, only: %i[index show]
  resources :issues, only: %i[index create show update destroy]
  resources :comments, only: %i[index create show update destroy]
  resource :like, only: %i[create destroy]
end
