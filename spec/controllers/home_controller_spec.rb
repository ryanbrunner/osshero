require 'spec_helper'

describe HomeController do
  
  describe "#show" do
    it "should respond with a home presenter" do
      get :show
      assigns[:home].should be_a HomePresenter
    end
  end
end