class HelpRequestsController < InheritedResources::Base
  actions :new, :create, :update

  def new
    @help_request = HelpRequest.new(:requester => current_user)
  end
end
