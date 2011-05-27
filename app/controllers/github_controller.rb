require 'git_hook'

class GithubController < ApplicationController
  def post_commit
    logger.info "payload received."
    hook = GitHook.new(ActiveSupport::JSON.decode(params[:payload]))
    hook.perform

    render :text => 'OK'
  end

  #HELPME: Add an action to merge
end
