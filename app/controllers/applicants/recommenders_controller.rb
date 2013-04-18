class Applicants::RecommendersController < ApplicationController
  before_filter :authenticate_applicant!
  
  def edit
    if current_applicant.recommendations.count == 0
      r = current_applicant.recommendations.build      
    end
    
    render :edit
  end

  def update
    if current_applicant.update_attributes params[:applicant]
      redirect_to applicant_status_url
    else
      render :edit
    end
  end
  
end
