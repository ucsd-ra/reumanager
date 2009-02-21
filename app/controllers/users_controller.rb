class UsersController < ApplicationController
  before_filter :login_from_cookie, :login_required, :except => [ :welcome, :thanks, :observe_perm, :observe_cit, :observe_dis, :observe_pcollege, :app_thanks, :rec_thanks, :resend_request ]
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  # render new.rhtml
  def new
    if current_user && current_user.submit_date      
      flash[:notice] = 'You cannot submit your application twice.'
      redirect_to "/status"
    else
      @user = User.new
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
      logout_killing_session!
      redirect_back_or_default('/thanks')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error]  = "There were errors with your form, please try again or contact nsfreu@bioeng.ucsd.edu"
      render :action => 'new'
    end
  end
  
  def edit
    if current_user && current_user.submit_date      
      flash[:notice] = 'You cannot submit your application twice.'
      redirect_to "/status"
    else
      @user = User.find(current_user.id)
    end
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Personal Data was successfully updated.'
      redirect_to :action => "edit"
    else
      render :action => "edit"
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
    if params[:disability] == "Yes"
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"          
        page[:dis].show
      end
    else
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"
        page[:dis].hide
      end
    end
  end
  
  def submit
    if current_user.submit_date      
      flash[:notice] = 'You cannot submit your application twice.'
      redirect_to "/status"
    else
      return unless request.post?
      current_user.send_app_confirmation
      current_user.send_rec_request
      redirect_to "/app_thanks"
    end
  end
  
  def app_thanks
     logout_killing_session!
  end
  
  def resend_request
    if current_user.completed == nil && current_user.send_rec_request
      current_user.rec_request = Time.now
    else
      flash[:notice] = 'Sorry, you can no longer resend your request, your application is complete.'
      redirect_to "/status"
    end
  end
  
end
