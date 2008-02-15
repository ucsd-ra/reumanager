require File.dirname(__FILE__) + '/../test_helper'

class RecommendationMailerTest < ActionMailer::TestCase
  tests RecommendationMailer
  def test_request
    @expected.subject = 'RecommendationMailer#request'
    @expected.body    = read_fixture('request')
    @expected.date    = Time.now

    assert_equal @expected.encoded, RecommendationMailer.create_request(@expected.date).encoded
  end

end
