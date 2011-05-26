class HomePresenter
  attr_reader :help_requests

  def initialize(params)
    @help_requests = HelpRequest.all
  end
end