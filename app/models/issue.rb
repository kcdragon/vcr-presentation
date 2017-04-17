class Issue
  include ActiveModel::Model

  REPOSITORY = 'https://api.github.com/repos/kcdragon/vcr-presentation'

  attr_accessor :title

  def self.all
    uri = URI.parse("#{REPOSITORY}/issues")
    response = Net::HTTP.get_response(uri)

    JSON.parse(response.body).map do |issue_data|
      Issue.new(
        title: issue_data['title']
      )
    end
  end

  def self.create(issue)
    uri = URI.parse("#{REPOSITORY}/issues")
    request = Net::HTTP::Post.new(uri)
    request.body = JSON.generate(title: issue.title)
    request.basic_auth("user", "token")

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    JSON.parse(response.body)
  end
end
