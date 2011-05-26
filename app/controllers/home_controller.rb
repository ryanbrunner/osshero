class HomeController < ApplicationController
  def show
    @home = HomePresenter.new(params)
  end
end
