class Applicants::RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?
  before_action :auth, :only => [:status, :update, :submit]
  before_action :check_deadline, :only => [:submit]

  # GET /resource/edit
  def edit
    @applicant.set_state
    @applicant.addresses.build unless @applicant.addresses.count > 0

    render :edit
  end

  # PUT /resource
  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  # We need to use a copy of the resource because we don't want to change
  # the current applicant in place.
  def update
    @applicant = Applicant.find(current_applicant.id)

    # remove blank address attributes to prevent validation error
    remove_blank_attribs

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
      # Sign in the applicant bypassing validation in case the password changed
      sign_in @applicant, :bypass => true
      @applicant.set_state
      redirect_to '/applicants/records'
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
      redirect_to root_path
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

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :email, :password, :password_confirmation])
  end


  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  # check if we need password to update applicant data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(applicant, params)
    applicant.email != params[:applicant][:email] || !params[:applicant][:password].blank?
  end

  def remove_blank_attribs
  #  debugger
    params[:applicant][:addresses_attributes].to_unsafe_h.each do |attribs|
      # remove destroy flag unless it's set to true/1
      attribs[1][:_destroy] = '1' if attribs[1][:address].blank? && attribs[1][:city].blank? && attribs[1][:zip].blank?
    end
  end

end
