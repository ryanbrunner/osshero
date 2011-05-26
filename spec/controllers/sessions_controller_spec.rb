require 'spec_helper'

describe SessionsController do
  describe "#create" do
    before :each do
      request.env['omniauth.auth'] = {'uid' => Factory.next(:uid) }
    end

    it "should redirect to the home page" do
      post :create, :provider => 'github'
      response.should redirect_to root_path
    end

    it "should try to find a user based on the provider and uid" do
      User.should_receive(:find_or_create_from_omniauth).and_return(Factory.build(:user))
      post :create, :provider => 'github'
    end

    context "Existing user session" do
      before :each do
        sign_in Factory.create :user
      end

      it "should not create a new authentication" do
        request.env['omniauth.auth'] = {'uid' => Factory.create(:user).uid }
        lambda do
          post :create, :provider => 'github'
        end.should_not change(User, :count)
      end
    end
    context "No existing user session" do
      before :each do
        sign_out
      end

      it "should create a user session" do
        post :create, :provider => 'github'
        session[:user_id].should_not be_nil
      end
    end
  end
end