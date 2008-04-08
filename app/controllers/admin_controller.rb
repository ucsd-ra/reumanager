require 'pdf/writer'
class AdminController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_from_cookie, :login_required
  
  def report
  end
    
  def create_report
    case params[:order]
    when "created_at"
      @students = Student.find(:all, :order => "created_at ASC")
    when "lastname"
      @students = Student.find(:all, :order => "lastname ASC")
    when "gpa"
      @students = Student.find(:all, :order => "gpa DESC")
    end
    render :layout => false
  end
  
end