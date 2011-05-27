class User < ActiveRecord::Base
  validates :uid, :presence => true
  validates :provider, :presence => true

  def self.named(name)
    where(:nickname => name).first
  end

  def self.find_or_create_from_omniauth(provider, auth)
    raise "No provider defined" if provider.empty?
    raise "No uid defined" unless auth['uid']

    User.find_or_create_by_provider_and_uid(provider, auth['uid']) do |u|
      if user_info = auth['user_info']
        u.email = auth['user_info']['email'] 
        u.github_url = auth['user_info']['urls']['GitHub'] if user_info['urls']
        u.nickname = auth['user_info']['nickname']
      end
    end
  end
end
