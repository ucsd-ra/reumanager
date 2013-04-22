class Applicants::AcademicRecordsController < ApplicationController
  before_filter :authenticate_applicant!
  
  def edit
    current_applicant.records.build unless current_applicant.records.count > 0
    current_applicant.awards.build unless current_applicant.awards.count > 0
    
    render :edit
  end

  def update
    if current_applicant.update_attributes params[:applicant]
      redirect_to applicants_records_url
    else
      render :edit
    end
  end

end
