require 'spec_helper'

describe HelpRequest do
  it { should validate_presence_of :title }
  it { should validate_presence_of :requester }

  it { should belong_to :requester }
  it { should belong_to :hero }
end