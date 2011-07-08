class HelpResponsesController < InheritedResources::Base
  respond_to :xml, :json, :html
  belongs_to :help_request

  def create
    create! do |success, failure|
      # fork the project    
      project = resource.help_request.project
      
      conn = Faraday.new(:url => "https://#{auth_info}@api.github.com/") do |builder|
        builder.request  :url_encoded
        builder.request  :json
        builder.response :logger
        builder.adapter  :net_http
      end

      response = conn.post "#{fork_command(project)}"   
    end
  end


  def complete
    # create a pull request
  end

 private

  def auth_info
    "#{current_user.nickname}:M0rsn3ja"
  end



  def fork_command(project)
  #  "repos/#{project.user.nickname}/#{project.repository}/forks"
      "repos/okonski/github-api-client/forks"
  end
end

