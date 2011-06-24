class HelpResponsesController < InheritedResources::Base
  respond_to :xml, :json, :html
  belongs_to :help_request

  include Octopi

  def create
    authenticated_with :login => current_user.nickname, :token => current_user.token do
      repo = Repository.find(:name => "influitive-app", :user => "influitive")

      raise repo
    end
  end

  def complete
    authenticated_with :login => current_user.nickname, :token => current_user.token do
      
    end
  end
end

