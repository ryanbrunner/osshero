module UsersHelper
  extend ActiveSupport::Memoizable

  def current_user_status
    if current_user
      "Signed in as #{link_to current_user.nickname, current_user.github_url}".html_safe
    else
      render 'users/sign_in' 
    end
  end

  def current_user
    session[:user_id] ? User.find(session[:user_id].to_i) : nil
  end
  memoize :current_user
end