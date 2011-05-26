module HelpRequestHelper
  def link_to_help(help_request)
    link_to "I want to help!", 
            help_request_path(help_request, :help_request => { :hero_id => current_user }), 
            :method => :put
  end
end