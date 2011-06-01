class UsersController < ApplicationController
  before_filter :login_from_cookie, :login_required, :except => [ :saved, :activate, :activated, :welcome, :thanks, :new, :create, :observe_perm, :observe_cit, :observe_dis, :observe_pcollege, :app_thanks, :rec_thanks, :reset, :forgot, :reactivate, :emailed, :pwreset ]
  before_filter :application_complete?, :except => [ :saved, :activate, :activated, :welcome, :thanks, :new, :create, :observe_perm, :observe_cit, :observe_dis, :observe_pcollege, :app_thanks, :rec_thanks, :status, :resend_request ]
  ssl_required :index, :new, :create, :edit, :update, :status, :observe_perm, :observe_cit, :observe_dis, :observe_pcollege, :resend_request, :submit, :saved, :reset, :forgot, :reactivate, :emailed, :pwreset
  
#  def activate
#    @user = User.find_by_token(params[:token])
#    if @user && @user.activated_at = Time.now && @user.save && 
#      flash[:notice] = 'Your account has been activated'
#      redirect_to :controller => 'academic_records', :action => 'new'
#    end
#  end
  
  def activate
    logout_keeping_session!
    user = User.find_by_token(params[:token]) unless params[:token].blank?
    case
    when (!params[:token].blank?) && user && !user.active?
      user.activate!
      redirect_back_or_default(:controller => "activated")
    when params[:token].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default(:controller => "sessions", :action => "new")
    else
      flash[:error] = "We couldn't find a user with that activation code. Please double check your email to make sure you copied the correct code, or maybe you've already activated -- try signing in."    
      redirect_back_or_default(:controller => "sessions", :action => "new")
    end
  end
  
  def index
    if current_user && current_user.submitted_at && !is_admin
      flash[:notice] = 'You cannot submit your application twice.'
      redirect_to( :controller => "users", :action => "status" )
    elsif current_user
      redirect_to edit_user_url(current_user)
    end
  end
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  # render new.rhtml
  def new
    if current_user && current_user.submitted_at
      flash[:notice] = 'You cannot submit your application twice.'
      redirect_to( :controller => "users", :action => "status" )
    else
      logout_killing_session!
			if Time.now > Setting.application_deadline.to_date
	      flash[:notice] = 'The application deadline has past.'
      	redirect_to(:controller => 'welcome')
      else
				@user = User.new
			end
    end
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.login = @user.email
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      @user.send_reg_confirmation
      logout_killing_session!
      redirect_back_or_default({ :controller => 'users', :action => 'thanks' })
    else
      render :action => 'new'
    end
  end
  
  def edit
    if current_user && current_user.submitted_at && !is_admin
      flash[:notice] = 'You application has already be submitted.'
      redirect_to( :controller => "users", :action => "status" )
    else
      current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
      @user = User.find(@id)
    end
  end
  
  def update
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Personal Data was successfully updated.'
      redirect_to :controller => "academic_records", :id => @id
    else
      render :action => "edit", :id => @id
    end
  end
  
  def observe_perm
    @paddress = params[:paddress]
    if @paddress == 'no'
      render :update do |page|
        page[:presidence].show
        page[:observers].replace_html :partial => "layouts/observers"
      end
    else
      render :update do |page|
        page[:presidence].hide
        page[:observers].replace_html :partial => "layouts/observers"
      end
    end
  end
  
  def observe_cit
    if params[:student_citizenship] != "United States"
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"
        page[:cor].show
      end
    else
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"
        page[:cor].hide
      end
    end
  end

  def observe_dis
    case params[:disability]
    when "Yes"
      render :update do |page|
        page[:dis].show
      end
    when "No"
      render :update do |page|
        page[:dis].hide
        page[:user_disability].value = "No"
      end
    else
      render :update do |page|
        page[:dis].hide
        page[:user_disability].value = ""
      end
    end
  end
  
  def submit
    if current_user.submitted_at      
      flash[:notice] = 'You cannot submit your application twice.'
      render :update do |page|
        page.redirect_to( :controller => "users", :action => "status" )
      end
    else
      @user = current_user
      return unless request.post?
      current_user.send_app_confirmation
      current_user.send_rec_request
      render :update do |page|
        page.redirect_to( :controller => "users", :action => "app_thanks" )
      end
    end
  end

	def status
		@user = current_user
		@recommendation = current_user.recommendation
		@recommender = current_user.recommender
		logout_killing_session!
	end
  
  def app_thanks
     logout_killing_session!
  end
  
  def resend_request
    ## check to make sure they are logged in and if the application is incomplete 
    if current_user && current_user.completed_at == nil
      ## used to throttle the amount of requests to 1 every 3 hrs.
      if current_user.rec_request_at == nil || ((Time.now - current_user.rec_request_at)/60) > 180
        current_user.send_rec_request
        flash[:notice] = 'Your recommendation request has been resent.'
      else
        flash[:notice] = 'Sorry, you must wait at least 3 hours before sending another recommendation request.'
      end
    else
      flash[:notice] = 'Sorry, you can no longer resend your request, your application is complete.'
    end
    redirect_to( :controller => "users", :action => "status" )
  end

  def forgot
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.make_token
      @user.save_with_validation(false)
      UserMailer.deliver_reset_password(@user)
      flash[:notice] = "Password reset link, sent."  
      redirect_to( :action => "emailed")
    else
      flash[:notice] = "There was an error or no user by that email."  
      render :action => 'forgot'
    end
  end

  def reset
    unless @user = User.find_by_token(params[:id])
      redirect_to :controller =>'sessions', :action => 'new'
    end

    if request.post?
      @user = User.find_by_token(params[:id])
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
    
      if @user.save && params[:password] != '' && params[:password_confirmation] != '' && params[:password]
        logout_killing_session!
        flash[:notice] = 'Password was updated, please login.'
        redirect_to :action => 'pwreset'
      else
        render :action => "reset", :id => @user.token
      end

    end
  end

  def reactivate
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.send_reg_confirmation
      @user.save_with_validation(false)
      flash[:notice] = "Activation link sent"  
      redirect_to( :action => "emailed"  )
    else
      flash[:notice] = "There was an error or no user by that email."  
      render :action => 'reactivate'
    end    
  end
  
  def pwreset
  end
  
end