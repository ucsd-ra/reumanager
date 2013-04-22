class Applicants::RegistrationsController < Devise::RegistrationsController

  # GET /resource/edit
  def edit
    render :edit
  end
  
  # PUT /resource
  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  # We need to use a copy of the resource because we don't want to change
  # the current applicant in place.
  def update
    @applicant = Applicant.find(current_applicant.id)

    successfully_updated = if needs_password?(@applicant, params)
      @applicant.update_with_password(params[:applicant])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:applicant].delete(:current_password)
      @applicant.update_without_password(params[:applicant])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the applicant bypassing validation in case his password changed
      sign_in @applicant, :bypass => true
      redirect_to edit_applicant_registration_url
    else
      render "edit"
    end
  end

  # GET /resource/status
  # Show view of profile
  def status
    @applicant = current_applicant
    @applicant.validates_application_completeness if @applicant
  end
  
  private
  
  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  # check if we need password to update applicant data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(applicant, params)
    applicant.email != params[:applicant][:email] || !params[:applicant][:password].blank?
  end

end