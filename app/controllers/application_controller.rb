# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e139ceb5b64892fab091458efd4d4528'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation, :lastname, :dob, :street, :city, :state, :zip, :phone, :pstreet, :pcity, :pstate, :pzip, :pphone, :citizenship, :cresidence, :gender, :ethnicity, :race, :disability

  require 'pdf/writer'
  include AuthenticatedSystem
  include SslRequirement
  
  def ssl_required?
    return false if RAILS_ENV == 'test' || RAILS_ENV == 'development'
    super
  end
  
  before_filter  :set_p3p

  def set_p3p
    response.headers["P3P"]="CP='CAO PSA OUR'"
  end

  
end
