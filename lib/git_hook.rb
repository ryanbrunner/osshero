class GitHook
  def initialize(payload)
    @payload = payload
  end

  def perform
    Rails.logger.info "Received GitHub commit."

    commit_data.each do |data|
      Rails.logger.info "   Checking for commits in #{data[:user]}/#{data[:repo]}/#{data[:sha]}"
      find_requests_in data
    end
  end

  private
    def commit_data
      user = @payload['repository']['owner']['name']
      repo = @payload['repository']['name']

      @payload['commits'].map { |c| {:user => user, :repo => repo, :sha => c['id'] } }
    end

    def find_requests_in (commit_params)
      data = get_commit_data(commit_params)
      
      data.modified.each do |m|
        m['diff'].split('\n').each do |line|
          log_help_request if line =~ /#\s*HELPME/i
        end
      end
    end

    def log_help_request
      Rails.logger.info "   Logging Help Request"
      HelpRequest.create(:title => "HELP!! #{Time.now}")
    end

    def get_commit_data (params)
      Octopi::Commit.find(params)
    end

end