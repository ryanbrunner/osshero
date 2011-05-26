class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :users

  protected 
    def current_user
      session[:user_id] ? User.find(session[:user_id].to_i) : nil
    end
end
