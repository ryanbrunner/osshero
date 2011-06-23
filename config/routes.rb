Osshero::Application.routes.draw do
  
  resource :home, :only => :show

  resources :sessions, :only => :create
    match '/auth/:provider/callback' => 'sessions#create'

  resources :projects

  match '/github/post_commit' => 'github#post_commit'

  resources :help_requests, :only => [:new, :create, :update, :index]

  root :to => 'home#show'
end
