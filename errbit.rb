# Require the hoptoad_notifier gem in your App.
# ---------------------------------------------
#
# Rails 3 - In your Gemfile
# gem 'airbrake'
#
# Rails 2 - In environment.rb
# config.gem 'airbrake'
#
# Then add the following to config/initializers/errbit.rb
# -------------------------------------------------------

# Airbrake.configure do |config|
#   config.project_key = '5a475a8c0022c1740ed51ac6794d5c25'
#   config.project_id    = 153567
# end

# Set up Javascript notifications
# -------------------------------
#
# To receive notifications for javascript errors,
# you should add <%= airbrake_javascript_notifier %> to the top of your layouts.
#
# Testing
# -------
#
# Rails 2 - you'll need to vendor airbrake to get the rake tasks
# rake gems:unpack GEM=airbrake
#
# Run:
# rake airbrake:test
# refresh this page
