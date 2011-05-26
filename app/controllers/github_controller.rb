class GithubController < ApplicationController
  def post_commit
    logger.info "payload received: #{params[:payload]}"
    render :text => 'OK'
  end
end
