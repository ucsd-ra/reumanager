# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  ssl_required :new, :create, :destroy, :note_failed_signin

  # render new.rhtml
  def new
    logout_killing_session!
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
        self.current_user = user
        new_cookie_flag = (params[:remember_me] == "1")
        handle_remember_cookie! new_cookie_flag
        if user && user.role && user.role.name == "admin"
          redirect_to( :controller => "admin" )
        else
          if user.submitted_at
            redirect_to( :controller => "users", :action => "status" )
          else
            # closed registration, prevent users from continuing unfinished apps or creating new ones
            redirect_to( :controller => "users", :action => "edit" )
          end
        end
        flash[:success] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    if current_user && current_user.completed_at || current_user && current_user.submitted_at || current_user && current_user.role_id == 1
      logout_killing_session!
      redirect_back_or_default( :controller => "welcome" )
    else
      logout_killing_session!
      redirect_back_or_default( :controller => "users", :action => "saved" )
    end
  end
  
  def forgot
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.make_token
      @user.save_with_validations(false)
      UserMailer.deliver_reset_password(@user)
      flash[:notice] = "Password reset link, sent."  
      redirect_to( :controller => "sessions", :action => "emailed"  )
    else
      flash[:notice] = "There was an error or no user by that email."  
      render :action => 'forgot'
    end
  end

  def activate
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.send_reg_confirmation
      @user.save_with_validations(false)
      flash[:notice] = "Activation link sent"  
      redirect_to( :controller => "sessions", :action => "emailed"  )
    else
      flash[:notice] = "There was an error or no user by that email."  
      render :action => 'activate'
    end    
  end
  
protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
