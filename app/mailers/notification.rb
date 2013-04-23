class Notification < ActionMailer::Base
  default from:  "Bioengineering Institute of California <demo@reumanager.com"
  default url: "https://reumanager.com"
  default content_type: "text/plain"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.confirmation.subject
  #
  #def confirmation
   # @greeting = "Hi"
  #  mail to: "to@example.org"
  #end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.update.subject
  #
  #def update
  #  @greeting = "Hi"
#    mail to: "to@example.org"
 # end
   
  def application_submitted(applicant)
   @applicant = applicant
   mail(:to => applicant.email, :subject => "REU application received for #{applicant.name}")
  end

  def recommendation_request(recommendation)
    @recommendation = recommendation
    mail(:to => recommendation.recommender.email, :subject => "REU recommendation request for #{recommendation.applicant.name}")
  end
  
  def recommendation_follow_up_request(recommendation)
    @recommendation = recommendation
    mail(:to => recommedation.recommender.email, :subject => "REU follow-up recommendation request for #{recommendation.applicant.name}")
  end  

  def recommendation_received(recommendation)
    @recommendation = recommendation
    mail(:to => recommedation.recommender.email, :subject => "REU recommendation received for #{recommendation.applicant.name}")
  end  
  
  def application_complete(applicant)
    @applicant = applicant
    mail(:to => applicant.email, :subject => "REU application complete for #{applicant.name}")
  end
  
end
