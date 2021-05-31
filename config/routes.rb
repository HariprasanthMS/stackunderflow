Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get '/my_answers', to: 'static_pages#my_answers'
  get '/my_questions', to: 'static_pages#my_questions'
  get '/my_voted_questions', to: 'static_pages#my_voted_questions'
  get '/search', to: 'static_pages#search'
  get '/signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get :questions
    end
  end

  resources :users do
    member do
      get :answered_questions
    end
  end

  resources :users do
    member do
      get :voted_questions
    end
  end
  
  resources :questions
  resources :answers, only: [:create, :destroy]
  resources :topics,  only: [:show, :index]
  resources :user_topic_relations, only: [:create, :destroy]
  resources :votes
end
