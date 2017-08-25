class Applicants::RecommendationsController < ApplicationController
  before_action :authenticate_applicant!, only: :resend_request
  before_action :find_recommendation, :except => [:resend_request]

  # GET /recommendations/:token
  def edit; end

  # POST /recommendations
  def resend_request
    recommendation = current_applicant.recommendations.find_by_recommender_id(params[:id])
    if recommendation.requestable?
      recommendation.update_attribute :request_sent_at, Time.now
      Notification.recommendation_follow_up_request(recommendation).deliver
      redirect_to(applicant_status_path, flash: { success: 'Your recommendation follow-up request has been sent.' } )
    else
      redirect_to(applicant_status_path, :flash => { :error => "You can only make a recommendation request once every 24 hours. It was last sent at #{recommendation.request_sent_at.strftime("%A, %b %d, %l:%M %p")}" })
    end
  end

  # PUT /recommendations/:token
  def update
    if @recommendation.update_attributes params[:recommendation]
      @recommendation.applicant.recommendation_recieved
      redirect_to(thanks_path)
    else
      render :edit
    end
  end

  private

  def find_recommendation
    @recommendation = Recommendation.find_by_token params[:token]
  end

end
