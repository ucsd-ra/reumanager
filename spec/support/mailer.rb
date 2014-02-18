module Mailer
  Rails.application.routes.default_url_options[:host] = 'test.host'

  def last_email
    ActionMailer::Base.deliveries.last
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end
end
