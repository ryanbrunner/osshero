class GitHook
  def initialize(payload)
    @payload = payload
    @user_name = @payload['repository']['owner']['name']
    @repo = @payload['repository']['name']
  end

  def perform
    Rails.logger.info "Received GitHub commit."
    return unless @user = User.named(@user_name)

    commit_data.each do |data|
      Rails.logger.info "   Checking for commits in #{data[:user]}/#{data[:repo]}/#{data[:sha]}"
      find_requests_in data
    end
  end

  private
    def commit_data
      @payload['commits'].map { |c| {:user => @user_name, :repo => @repo, :sha => c['id'] } }
    end

    def find_requests_in (commit_params)
      data = get_commit_data(commit_params)
      
      data.modified.each do |m|
        m['diff'].split('\n').each do |line|
          line.match(/^\+\s*#\s*HELPME\s*:\s*(.*)/i) do |m| 
            log_help_request :title => m[1]
          end
        end
      end
    end

    def log_help_request (params)
      Rails.logger.info "   Logging Help Request"
      HelpRequest.create(params.merge(:requester => @user))
    end

    def get_commit_data (params)
      Octopi::Commit.find(params)
    end

end