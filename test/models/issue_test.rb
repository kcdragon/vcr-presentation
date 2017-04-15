require 'test_helper'

class IssueTest < ActiveSupport::TestCase

  def test_all_issues
    issues = VCR.use_cassette('issue/all') do
      Issue.all
    end

    assert_equal 1, issues.count

    issue = issues.first
    assert_equal 'Test Issue #1', issue.title
  end
end
