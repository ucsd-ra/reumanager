class Applicants::RegistrationsController < Devise::RegistrationsController
  
  # GET /resource/status
  # Show view of profile
  def status
    @user = current_applicant
    @user.validates_application_completeness if @user
  end
  

end