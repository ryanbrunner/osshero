module HelpRequestHelper
  def link_to_help(help_request)
    link_to "I want to help!", 
            new_help_request_help_response_path(help_request, :help_response => {:user_id => current_user})
  end
end