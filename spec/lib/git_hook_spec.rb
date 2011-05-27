require 'spec_helper'

describe GitHook do
  let :payload do
    {
      'commits' => [
        {'url' => 'http://null.com/1'}
      ] 
    }
  end

  let :two_commit_payload do
    {
      'commits' => [
        {'url' => 'http://null.com/1'},
        {'url' => 'http://null.com/2'}
      ] 
    }
  end

  let :matching_commit do
    {
      'commit' => {
        'modified' => [
          { 'diff' => '\n\n+   # HELPME: I need help' }            
        ]
      }
    }
  end

  let :non_matching_commit do
    {
      'commit' => {
        'modified' => [
          { 'diff' =>  '\n\n+  HELPME: I need help' }            
        ]
      }
    }
  end

  it "should pull all commits" do
    Net::HTTP.should_receive(:get).with(URI.parse('http://null.com/1.json')).and_return(non_matching_commit.to_json)

    hook = GitHook.new(payload)
    hook.perform
  end

  it "should log a help request when it sees the correct token" do
    Net::HTTP.stub(:get).and_return(matching_commit.to_json)
    HelpRequest.should_receive(:create)
    
    hook = GitHook.new(payload)
    hook.perform
  end

  it "should log multiple help requests when multiple commits have tokens" do
    Net::HTTP.stub(:get).and_return(matching_commit.to_json)
    HelpRequest.should_receive(:create).twice
    
    hook = GitHook.new(two_commit_payload)
    hook.perform
  end

  it "should not log a help request for an invalid token" do
    Net::HTTP.stub(:get).and_return(non_matching_commit.to_json)
    HelpRequest.should_not_receive(:create)
    
    hook = GitHook.new(payload)
    hook.perform
  end
end