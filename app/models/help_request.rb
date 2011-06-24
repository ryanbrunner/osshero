class HelpRequest < ActiveRecord::Base
  validates :title, :presence => true
  validates :requester, :presence => true

  belongs_to :requester, :class_name => 'User'
  belongs_to :hero, :class_name => 'User'

  has_many :help_responses
end
