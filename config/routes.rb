Rails.application.routes.draw do
  get 'friends/index'

  get 'friends/destroy'

  resources :friend_requests
  get 'sessions/new'

  resources :subjects
  resources :instructors
  resources :courses
  resources :users
  root 'login#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/results', to: 'courses#results'
  post '/enrollments/create', to: 'courses#create_enrollment'
  delete 'enrollments/delete', to: 'courses#destroy_enrollment'
  delete 'enrollments/deletereg', to: 'courses#destroy_enrollment_reg'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
