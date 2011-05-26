require 'spec_helper'

describe HomePresenter do
  let :params do
    {}
  end

  it "should load a list of requests" do
    HelpRequest.should_receive(:all)
    HomePresenter.new(params)
  end
end