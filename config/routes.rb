Osshero::Application.routes.draw do
  
  resource :home, :only => :show

  resources :sessions, :only => :create
    match '/auth/:provider/callback' => 'sessions#create'

  resources :help_requests, :only => [:new, :create, :update]

  root :to => 'home#show'
end
