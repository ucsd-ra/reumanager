# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable
  
  helper :all # include all helpers, all the time
#  before_filter  :set_p3p

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e139ceb5b64892fab091458efd4d4528'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation, :lastname, :dob, :street, :city, :state, :zip, :phone, :pstreet, :pcity, :pstate, :pzip, :pphone, :citizenship, :cresidence, :gender, :ethnicity, :race, :disability

  require 'pdf/writer'
  require 'spreadsheet'
  include AuthenticatedSystem
  include SslRequirement
  
	rescue_from(ActionController::RoutingError) { render :file => 'public/404.html', :status => 404 }
	rescue_from(ActionController::InvalidAuthenticityToken) { render :file => 'public/422.html', :status => 422}

# I want to exclude my IPs from the logs, but the below code didn't work as I had hoped.
#
#	before_filter :filter_my_ips
#	
#	def filter_my_ips
#		@my_ips = ["76.88.119.175", "132.239.8.57", "184.72.43.42", "127.0.0.1"]
#		if @my_ips.include?(request.remote_ip)
#			logger.level = Logger::FATAL
#		else
#			logger.level = Logger::INFO
#		end
#	end
	
  def ssl_required?
    return false if RAILS_ENV == 'test' || RAILS_ENV == 'development'
    super
  end

  def set_p3p
     response.headers["P3P"]='CP="CAO PSA OUR"'
  end
  
  def check_admin
    unless current_user && current_user.role.name == "admin"
      flash[:notice] = "You are not an administrator."
      redirect_to(:back || :controller => "welcome")
    end
  end

  def application_complete?
    if current_user && current_user.submitted_at && !is_admin
      flash[:notice] = 'You can no longer edit your application once it has been submitted.'
      redirect_to(:controller => "users", :action => "status")
    end
  end
  
  def is_admin
    current_user.role.name == "admin" || current_user.id == 1 
  end
    
#	def logger
#		@hosts = ['76.88.119.175', '184.72.43.42', '132.239.8.57']
#		if @hosts.include?(request.remote_ip)
#			logger.silence
#			super
#		else
#			super
#		end
#	end
end