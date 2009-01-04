class AdminController < ApplicationController
before_filter :login_from_cookie, :login_required, :check_admin

  def check_admin
    unless current_user and (current_user.id == 1 || current_user.id == 6)
      flash[:notice] = "You are not an administrator."
      redirect_to "/"
    end
    
  end
  
  def index
    case params[:sort]
    when "name"
      @students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ])
#    when "college"
#      @students = User.find(:all, :order => 'college ASC')
#    when "major"
#      @students = User.find(:all, :order => 'major ASC')
#    when "gpa"
#      @students = User.find(:all, :order => "gpa DESC")
    when "date"
      @students = User.find(:all, :order => "created_at ASC", :conditions => [ "id != ? and id != ?", 1, 6 ])
    else
      @students = User.find(:all, :conditions => [ "id != ? and id != ?", 1, 6 ])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  
  def show
    @students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ])
    @user = User.find(params[:id])
  end
  
  def observe_student_select
    render :update do |page|
      page.redirect_to :action => "show", :id => params[:student_select]
    end
  end
  
  def report
    @students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ])
    pdf = PDF::Writer.new
    Recommendation.find(:all).each { |r| r.make_pdf }
    if pdf.save_as("#{RAILS_ROOT}/public/pdf/complete_report.pdf")
      flash[:notice] = "Report created."
      @report = "/pdf/complete_report.pdf"
    else
      flash[:notice] = "There were errors. Please try again or contact jgrevich@ucsd.edu"
      redirect_to :action => "index"
    end
  end
  
  def delete
    if request.delete? and User.find(params[:id]).destroy
      flash[:notice] = "User has been permanently deleted." 
      redirect_to :action => "index"
    else
      flash[:notice] = "There was an error"
      redirect_to :action => "index"
    end
  end
end