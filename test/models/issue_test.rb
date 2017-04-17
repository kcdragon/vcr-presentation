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

  def test_create_issue
    title = 'Issue created from API #1'
    issue = Issue.new(title: title)
    VCR.use_cassette('issue/create') do
      Issue.create(issue)

      issues = Issue.all
      issue = issues.first
      assert_equal title, issue.title
    end
  end
end
