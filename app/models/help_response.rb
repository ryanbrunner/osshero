class HelpResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :help_request
end
