class SessionsController < ApplicationController
  def create
    provider = params[:provider]
    auth = request.env['omniauth.auth']

    user = User.find_or_create_from_omniauth(provider, auth)

    if user.id
      sign_in user
      flash[:notice] = "Signed in!"
    else
      flash[:error] = "Whoops! We weren't able to sign you in successfully. Please try again."
    end
    
    redirect_to root_path
  end

  private 
  
  def sign_in(user)
    session[:user_id] = user.id
  end
end
