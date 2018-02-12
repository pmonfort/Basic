Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'

  post '/endorsements' => 'endorsements#create'
  delete '/endorsements' => 'endorsements#destroy'

  delete '/skills/:id' => 'skills#destroy', as: :destroy_skills
  resources :users
end
