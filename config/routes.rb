Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  get '/about' => 'home#about'

  # resources :posts
  # get '/posts/new' => 'posts#new', as: :new_post
  #
  # post '/posts' => 'posts#create', as: :posts
  #
  # get'/posts' => 'posts#index'
  #
  # get '/posts/:id' => 'posts#show', as: :post
  #
  # get '/posts/:id/edit' => 'posts#edit', as: :edit_post
  #
  # patch '/posts/:id' => 'posts#update'
  # delete '/posts/:id' => 'posts#destroy'

  resources :posts do
    resources :comments do
      resources :favourites, only: [:create, :destroy], shallow: true
      # use shallow so that we don't have to care about url of posts and comments, too long
    end
  end
  resources :users do
  # root "posts#index"
    resources :passwords, only: [:edit, :update] do
      get :edit, on: :collection
      patch :update, on: :collection
    end
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :categories, except: [:destroy]

  # get '/signup' => 'users#new'
  # resources :users, expect: [:new]
  #
  # get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  # delete 'logout' => 'sessions#destroy'
end
