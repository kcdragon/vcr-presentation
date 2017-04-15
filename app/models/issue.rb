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
end
