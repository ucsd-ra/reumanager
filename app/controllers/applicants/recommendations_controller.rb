class Applicants::RecommendationsController < ApplicationController
  before_filter :authenticate_applicant!
  
  def edit
    current_applicant.recommenders.build unless current_applicant.recommenders.count > 0
    
    render :edit
  end

  def update
    if current_applicant.update_attributes params[:applicant]
      
    else
      render :edit
    end
  end
  
end
