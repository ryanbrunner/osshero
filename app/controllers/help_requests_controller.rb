class HelpRequestsController < InheritedResources::Base
  actions :new, :create, :update, :index

  def new
    @help_request = HelpRequest.new(:requester => current_user, :project => Project.new)
    # @projects = Octopi::User.find(current_user.nickname).repositories
  end

  def create
    repository_name = params[:help_request][:project][:repository]
    @project = Project.find_or_create_by_repository(repository_name, user: current_user)

    @help_request = HelpRequest.create(
      requester: current_user,
      title: params[:help_request][:title],
      description: params[:help_request][:description],
      project: @project
    )
  end

  protected

  def collection
    @help_requests ||= end_of_association_chain
  end

end
