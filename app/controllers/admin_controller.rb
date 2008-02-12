class AdminController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_from_cookie, :login_required
end