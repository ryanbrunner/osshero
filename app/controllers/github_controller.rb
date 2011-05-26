class GithubController < ApplicationController
  def post_commit
    render :text => params[:payload]
  end
end
