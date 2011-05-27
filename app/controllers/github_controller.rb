require 'git_hook'

class GithubController < ApplicationController
  def post_commit
    logger.info "payload received."
    hook = GitHook.new(ActiveSupport::JSON.decode(params[:payload]))
    hook.perform

    render :text => 'OK'
  end

  #HELPME: Make sure that only new lines generate a new help request.
end
