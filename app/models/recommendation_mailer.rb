class RecommendationMailer < ActionMailer::Base

  def request(sent_at = Time.now)
    @subject    = 'RecommendationMailer#request'
    @body       = {}
    @recipients = ''
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end
end
