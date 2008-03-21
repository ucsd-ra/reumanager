# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include SslRequirement
  include SimpleCaptcha::ControllerHelpers
  filter_parameter_logging :password
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '25d978808669907c9d5aa5c38672540d'

  ActionView::Base.field_error_proc = Proc.new do |html_tag,instance| 
    %(<span class="fieldWithErrors" style="color:red"></span>) + html_tag
  end 


  
end