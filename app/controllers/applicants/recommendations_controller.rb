class Applicants::RecommendationsController < ApplicationController
  before_filter :authenticate_applicant!, only: :resend_request
  before_filter :find_recommendation, :except => [:resend_request]
  
  # GET /recommendations/:token
  def edit; end

  # POST /recommendations
  def resend_request
    if current_applicant
      redirect_to(applicant_status_path, notice: 'test')
    else
      redirect_to(applicant_status_path, :flash => { :error => "You can only make a recommendation request once every 24 hours" })
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
