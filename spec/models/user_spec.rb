require 'spec_helper'

describe User do
  it { should validate_presence_of 'uid' }
  it { should validate_presence_of :provider }

  describe "#find_or_create_from_omniauth" do
    before(:each) do
      @provider = 'github'
      @auth = {
        'uid' => Factory.next(:uid),
        'user_info' => { 'nickname' => 'nick',
                         'urls' => { 'GitHub' => 'http://github.com/nick' },
                         'email' => 'nick@nick.com' }
      }
    end

    it "should create a new user if none exists in the database" do
      lambda do
        user = User.find_or_create_from_omniauth(@provider, @auth)
      end.should change(User, :count).by 1
    end
      
    it "should set the users properties" do
      user = User.find_or_create_from_omniauth(@provider, @auth)

      user.uid.should == @auth['uid']
      user.provider.should == @provider
      
      user.nickname.should == @auth['user_info']['nickname']
      user.email.should == @auth['user_info']['email']
      user.github_url.should == @auth['user_info']['urls']['GitHub']
    end

    it "should return an existing user if one already exists" do
      user = Factory.create(:user)

      lambda do
        User.find_or_create_from_omniauth(user.provider, 'uid' => user.uid)
      end.should_not change(User, :count)

    end

    it "should throw an exception if uid and provider are not in the array" do
      lambda {User.find_or_create_from_omniauth(@provider, :foo => 'bar')}.should raise_error
      lambda {User.find_or_create_from_omniauth('', @auth)}.should raise_error
    end

  end
end