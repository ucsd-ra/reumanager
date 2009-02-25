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
      @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ], :per_page => 15
#    when "college"
#      @students = User.find(:all, :order => 'college ASC')
#    when "major"
#      @students = User.find(:all, :order => 'major ASC')
#    when "gpa"
#      @students = User.find(:all, :order => "gpa DESC")
    when "date"
      @students = User.paginate :page => params[:page], :order => "created_at ASC", :conditions => [ "id != ? and id != ?", 1, 6 ], :per_page => 15
    else
      @students = User.paginate :page => params[:page], :conditions => [ "id != ? and id != ?", 1, 6 ], :per_page => 15
    end
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ])
    @user = @students.first
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  
  def show
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ])
    @user = User.find(params[:id])
  end
  
  def observe_student_select
    render :update do |page|
      page.redirect_to :action => "show", :id => params[:student_select]
    end
  end
  
  def report
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ]
    @user = @students.first
  end

  def incomplete_report
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ? and submit_date is null", 1, 6 ])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "id != ? and id != ? and submit_date is null", 1, 6 ]
    @user = @students.first
    if @all_students != nil
      render :action => "report"
    else
      flash[:notice] = "There are no incomplete applications"
      redirect_to :action => "report"
    end
  end

  def submitted_report
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ? and submit_date is not null and completed is null", 1, 6 ])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "id != ? and id != ? and submit_date is not null and completed is null", 1, 6 ]
    @user = @students.first
    if @all_students != nil
      render :action => "report"
    else
      flash[:notice] = "There are no submitted applications"
      redirect_to :action => "report"
    end
  end

  def complete_report
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ? and completed is not null", 1, 6 ])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "id != ? and id != ? and completed is not null", 1, 6 ]
    @user = @students.first
    if @all_students != nil
      render :action => "report"
    else
      flash[:notice] = "There are no complete applications"
      redirect_to :action => "report"
    end
  end
  
  def create_report
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ])
     @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "id != ? and id != ?", 1, 6 ]
     @user = @students.first
     pdf = PDF::Writer.new
     Recommendation.find(:all).each do |r|
       r.make_pdf(pdf)
       pdf.start_new_page
     end
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