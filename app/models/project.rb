class Project < ActiveRecord::Base
  belongs_to :user
  has_many :help_requests
  
  validate {
    _repo = "#{user.nickname}/#{repository}"
    
    # TODO: Check that this an exitsing repo via github api
  }

end
