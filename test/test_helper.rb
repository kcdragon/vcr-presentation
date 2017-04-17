ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock

  config.register_request_matcher :label_in_query_string do |request_1, request_2|
    labels_in_query_string = ->(request) do
      query_string = URI.parse(request.uri).query
      query_string.split('&').reduce({}) do |memo, pair|
        key, value = pair.split('=')
        memo.merge(key => value)
      end['labels']
    end

    labels_1 = labels_in_query_string.(request_1)
    labels_2 = labels_in_query_string.(request_2)

    labels_1.split(',').sort == labels_2.split(',').sort
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
