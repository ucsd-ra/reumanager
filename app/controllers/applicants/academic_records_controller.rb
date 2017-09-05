class Applicants::AcademicRecordsController < ApplicationController
  before_action :authenticate_applicant!
  before_action :set_state

  def edit
    current_applicant.records.build unless current_applicant.records.count > 0
    current_applicant.awards.build unless current_applicant.awards.count > 0

    render :edit
  end

  def update
    if current_applicant.update_attributes params[:applicant]
      current_applicant.can_complete_academic_info? ? current_applicant.complete_academic_info : current_applicant.incomplete_academic_info

      redirect_to '/applicants/recommenders'
    else
      render :edit
    end
  end

end
