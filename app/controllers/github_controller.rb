require 'git_hook'

class GithubController < ApplicationController
  def post_commit
    logger.info "payload received."
    hook = GitHook.new(params[:payload])
    hook.perform

    render :text => 'OK'
  end
end
