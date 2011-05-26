class GitHook
  def new(payload)
    @payload = ActiveSupport::JSON.decode(payload)
  end

  def perform
    logger.info @payload.to_yaml

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
      logger.info data.to_yaml
    end

    def get_commit_data (url)
      commit_data = Net::HTTP.get(URI.parse("#{url}.json"))
      ActiveSupport::JSON.decode(commit_data)
    end

end