class AdminController < ApplicationController
before_filter :login_from_cookie, :login_required

  def index
    case params[:sort]
    when "name"
      @students = Student.find(:all, :order => 'lastname ASC')
    when "college"
      @students = Student.find(:all, :order => 'college ASC')
    when "major"
      @students = Student.find(:all, :order => 'major ASC')
    when "gpa"
      @students = Student.find(:all, :order => "gpa DESC")
    when "date"
      @students = Student.find(:all, :order => "created_at ASC")
    else
      @students = Student.find(:all)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

end