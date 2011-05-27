require 'spec_helper'

describe GitHook do
  let :payload do
    {
      'commits' => [
        {'id' => '1'}
      ],
      'repository' => {
        'name' => 'testrepo',
        'owner' => {
          'name' => 'testuser'
        }
      }
    }
  end

  let :two_commit_payload do
    {
      'commits' => [
        {'id' => '1'},
        {'id' => '2'}
      ],
      'repository' => {
        'name' => 'testrepo',
        'owner' => {
          'name' => 'testuser'
        }
      } 
    }
  end

  let :matching_commit do
    OpenStruct.new(:modified => [{'diff' => '\n\n+   # HELPME: I need help' }])
  end

  let :non_matching_commit do
    OpenStruct.new(:modified => [{'diff' => '\n\n+   HELPME: I need help' }])
  end

  before(:each) do
    User.stub(:named).and_return(User.new)
  end

  it "should pull all commits" do
    Octopi::Commit.should_receive(:find).with(hash_including(:user => 'testuser',
                                                             :repo => 'testrepo',
                                                             :sha => '1')).and_return(non_matching_commit)

    hook = GitHook.new(payload)
    hook.perform
  end

  it "should log a help request when it sees the correct token" do
    Octopi::Commit.stub(:find).and_return(matching_commit)
    HelpRequest.should_receive(:create)
    
    hook = GitHook.new(payload)
    hook.perform
  end

  it "should log multiple help requests when multiple commits have tokens" do
    Octopi::Commit.stub(:find).and_return(matching_commit)
    HelpRequest.should_receive(:create).twice
    
    hook = GitHook.new(two_commit_payload)
    hook.perform
  end

  it "should not log a help request for an invalid token" do
    Octopi::Commit.stub(:find).and_return(non_matching_commit)
    HelpRequest.should_not_receive(:create)
    
    hook = GitHook.new(payload)
    hook.perform
  end

  it "should get the title of the help request from the comment" do
    Octopi::Commit.stub(:find).and_return(matching_commit)
    HelpRequest.should_receive(:create).with(hash_including(:title => 'I need help'))

    hook = GitHook.new(payload)
    hook.perform
  end
end