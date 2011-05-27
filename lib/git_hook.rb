class GitHook
  def initialize(payload)
    @payload = payload
  end

  def perform
    Rails.logger.info @payload.to_yaml

    commit_urls.each do |url|
      find_requests_in url
    end
  end

  private
    def commit_urls
      @payload['commits'].map { |c| c['url'] }
    end

    def find_requests_in (url)
      data = get_commit_data(url)
      
      data['commit']['modified'].each do |m|
        m['diff'].split('\n').each do |line|
          log_help_request if line =~ /#\s*HELPME/i
        end
      end
    end

    def log_help_request
      HelpRequest.create(:title => "HELP!! #{Time.now}")
    end

    def get_commit_data (url)
      commit_data = Net::HTTP.get(URI.parse("#{url}.json"))
      ActiveSupport::JSON.decode(commit_data)
    end

end