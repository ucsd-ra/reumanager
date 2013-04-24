class Applicants::RegistrationsController < Devise::RegistrationsController
  before_filter :auth, :only => [:status, :update, :submit]
    
  # GET /resource/edit
  def edit
    @applicant.set_state
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
      @applicant.set_state

      redirect_to @applicant.redirect_url
    else
      render "edit"
    end
  end

  # GET /resource/status
  # Show view of profile
  def status
    @applicant = current_applicant
    @applicant.validates_application_completeness
  end
  
  # GET /resource/submit
  # check that app is complete and mark as submitted, trigger confirmation email and recommendation request.
  def submit
    
    if current_applicant && current_applicant.submit_application && current_applicant.errors.empty?
      flash[:success] = "Application submitted."
      redirect_to current_applicant.redirect_url
    else
      flash[:error] = "You cannot submit your application until it is complete."
      redirect_to current_applicant.redirect_url
    end
  end
  
  private
  
  def auth
    :authenticate_applicant!
    redirect_to new_applicant_session_url unless current_applicant
  end
  
  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  # check if we need password to update applicant data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(applicant, params)
    applicant.email != params[:applicant][:email] || !params[:applicant][:password].blank?
  end
  
end