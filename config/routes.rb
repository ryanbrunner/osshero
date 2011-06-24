Osshero::Application.routes.draw do
  
  resource :home, :only => :show

  resources :sessions, :only => [:create, :destroy]
    match '/auth/:provider/callback' => 'sessions#create'
    match '/auth/sign_out' => 'sessions#destroy'

  resources :projects

  match '/github/post_commit' => 'github#post_commit'

  resources :help_requests, :only => [:new, :create, :update, :index] do
    resources :help_responses
  end

  root :to => 'home#show'
end
