module Applicants::RegistrationsHelper
  def recommendation_received_label(recommender)
    recommendation = current_applicant.recommendations(recommender).first
    raw recommendation.valid?  ? " <span class='label label-success'>[RECIEVED]</span>" : " <span class='label label-info'>[NOT RECIEVED]</span> &nbsp;&nbsp;&nbsp; #{ link_to 'Resend Request', applicants_recommendations_request_path(recommender), class: 'btn btn-mini', method: :post}" if current_applicant.submitted?
  end
end

