class AdminController < ApplicationController
before_filter :login_from_cookie, :login_required, :check_admin
ssl_required :index, :show, :select_student, :change_status, :report, :incomplete, :submitted, :complete, :create_report, :delete, :export, :expunge_excel_files, :close_export
require 'ftools'

  def index
    @total = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])    
    @incomplete = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is null and role_id = ?", 2 ]
    @submitted = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is null and role_id = ?", 2 ]
    @complete = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is not null and role_id = ?", 2 ]
  end
  
  def list
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])

		case params[:sort]
		when "name"
			order = "lastname ASC"
			#    when "college"
			#      @students = User.find(:all, :order => 'college ASC')
			#    when "major"
			#      @students = User.find(:all, :order => 'major ASC')
			#    when "gpa"
			#      @students = User.find(:all, :order => "gpa DESC")
			#    when "date"
			#      @students = User.paginate :page => params[:page], :order => "created_at ASC", :conditions => [ "role_id = ?", 2]
		end


		if params[:q] != nil
			and_conditions = []
			and_key_values = {}
			
			and_conditions << "users.role_id = :role_id AND"
			and_key_values[:role_id] = 2
			

			and_conditions << "(users.firstname like :q or users.lastname like :q or academic_records.college like :q or academic_records.major like :q or academic_records.gpa like :q )"
			and_key_values[:q] = "%#{params[:q]}%"

			conditions = []
			conditions << and_conditions.join(" ")
			conditions << and_key_values
			@students = User.paginate :page => params[:page], :order => order, :conditions => conditions, :include => :academic_record
		else
			@students = User.paginate :page => params[:page], :order => order, :conditions => ['role_id = ?', 2]
		end
		
    respond_to do |format|
      format.html { render :aciton => 'list' }# index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  
  def show
	  @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @user = User.find(params[:id])
  end
  
  def select_student
		render :update do |page|
			page.redirect_to :action => "show", :id => params[:student]
		end
  end

  def change_status
    @user = User.find(params[:id])
    @user.update_attribute(:status, params[:status])
    render :update do |page|
      page.insert_html :bottom, 'status', %(<h3 class='left positive' id="updated">Status Updated!</h3>)
      page[:updated].highlight
      page.delay(1) do
        page[:updated].fade
        page[:updated].remove
      end
    end
  end
    
  def report
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC'
  end

  def incomplete
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is null and role_id = ?", 2 ]
    render :action => "list"
  end

  def submitted
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is null and role_id = ?", 2 ]
    render :action => "list"
  end

  def complete    
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is not null and role_id = ?", 2 ]
    render :action => "list"
  end
  
  def create_report
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
     @students = User.paginate :page => params[:page], :order => 'lastname ASC'
     pdf = PDF::Writer.new
     Recommendation.find(:all).each do |r|
       r.make_pdf(pdf)
       pdf.start_new_page
     end
     if pdf.save_as("#{RAILS_ROOT}/public/pdf/complete.pdf")
       flash[:notice] = "Report created."
       @report = "/pdf/complete.pdf"
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
  
  def export
    # initialize new speadsheet
    @spreadsheet_dir = File.makedirs "#{RAILS_ROOT}/public/spreadsheets" unless File.exist?("#{RAILS_ROOT}/public/spreadsheets")
    @spreadsheet_file = "#{RAILS_ROOT}/public/spreadsheets/#{params[:id]}_applicants_#{Date.today}_#{Time.now.strftime("%H-%M_%p")}.xls"
    workbook = Spreadsheet::Workbook.new # Spreadsheet.open(spreadsheet_dir+spreadsheet_file)
    worksheet = workbook.create_worksheet :name => "Applicant Data"
    
    # create styles
    page_title_format = Spreadsheet::Format.new( :color => "black", :bold => true, :size => 30 )
    header_format = Spreadsheet::Format.new( :color => "black", :bold => true, :size => 12 )
    data_format = Spreadsheet::Format.new( :color => "black", :bold => true, :size => 10 )
    workbook.default_format = data_format
    
    # setup headers
    worksheet.row(0).default_format = page_title_format
    worksheet[0,0] = "2011 UCSD NSFREU Applicant Data" 
    worksheet.row(1).default_format = header_format
    worksheet.row(1).concat %w{ID Name Email Gender Race Ethnicity Disability Current\ University Academic\ Year Major/Minor GPA Recommender\ Name Recommender\ Association Overall\ Promise Undergrad\ Institution?}
    worksheet.row(1).default_format = header_format
    # get applicant data
    @applicants = User.all :order => "id ASC", :conditions => ["role_id = ? AND completed_at IS NOT ?", 2, nil], :include => [ :academic_record, :recommender, :recommendation ]
    
    # iterate over each applicant
    # @applicants.each_with_index do |a,i|
    @row = 1
    @applicants.each do |a|
      @row += 1
      worksheet.row(@row).concat [a.id, "#{a.firstname} #{a.lastname}", a.email, a.gender, a.race, a.ethnicity, a.disability, a.academic_record.college, a.academic_record.college_level, a.academic_record.major, a.academic_record.gpa, a.recommender.name, "#{a.recommender.department} / #{a.recommender.college}", a.recommendation.rating, a.recommendation.undergrad_inst]
    end
        
    # write file
    workbook.write @spreadsheet_file
    @filename = @spreadsheet_file.split("/").last
    render :update do |page|
      page[:overlay].show
      page[:opaque_overlay].show
      page[:wait_box].hide
      page[:excel_export].replace_html :partial => "excel_export"
      page[:excel_export].show
    end
  end
  
  def close_export
    # clean up tmp files
    expunge_excel_files
    render :update do |page|
      page[:excel_export].hide
      page[:overlay].hide
      page[:opaque_overlay].hide
      page[:wait_box].show
    end
  end
  
  protected
  def expunge_excel_files
    Dir["#{RAILS_ROOT}/public/spreadsheets/*"].each {|f| File.delete f} if File.exist?("#{RAILS_ROOT}/public/spreadsheets")
  end
  
end