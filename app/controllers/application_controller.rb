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
  # filter_parameter_logging :password
  #
  include AuthenticatedSystem
  
  ActionView::Base.field_error_proc = Proc.new do |html_tag,instance| 
    %(<span class="fieldWithErrors" style="color:red"></span>) + html_tag
  end
  
  
  require 'pdf/writer'
  
end
