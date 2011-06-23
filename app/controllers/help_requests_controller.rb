class HelpRequestsController < InheritedResources::Base
  actions :new, :create, :update, :index

  def new
    @help_request = HelpRequest.new(:requester => current_user)
  end

  protected
    
  def collection
    @help_requests ||= end_of_association_chain.paginate(params[:page])
  end
end
