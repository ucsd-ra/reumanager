class AdminController < ApplicationController
before_filter :login_from_cookie, :login_required, :check_admin
# ssl_required :index, :list, :show, :select_student, :change_status, :total, :incomplete, :submitted, :complete, :create_report, :delete, :export, :expunge_excel_files, :close_export, :select_status, :print
require 'ftools'

  def index
    @total = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @incomplete = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is null and role_id = ?", 2 ]
    @submitted = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is null and role_id = ?", 2 ]
    @complete = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is not null and role_id = ?", 2 ]
    @in_review = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'In Review', 2 ]
    @waitlisted = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'Waitlist',  2 ]
    @rejected = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'Reject',  2 ]
    @withdrawn = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'Withdrawn', 2]
    @accepted = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'Accept',  2 ]
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

		if params != nil
			and_conditions = []
			and_key_values = {}
			
			and_conditions << "users.role_id = :role_id AND"
			and_key_values[:role_id] = 2
			
			if params[:status] != nil
			  and_conditions << "users.status = :status AND"
			  and_key_values[:status] = (params[:status])
			end

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
      format.html # index.html. 	
      format.xml  { render :xml => @students }
    end
  end
  
  def show
	  @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @user = User.find(params[:id])
  end

  def select_status
		render :update do |page|
			page.redirect_to((params[:application_status]) || url_for(:controller => 'admin'))
		end
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
    
  def total
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :conditions => ['role_id = ?', 2], :page => params[:page], :order => 'lastname ASC'
		@export = User.all :order => 'lastname ASC', :conditions => [ "role_id = ?", 2 ]
		
    render :action => "list"
  end

  def incomplete
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is null and role_id = ?", 2 ]
		@export = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is null and role_id = ?", 2 ]
		
    render :action => "list"
  end

  def submitted
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is null and role_id = ?", 2 ]
		@export = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is null and role_id = ?", 2 ]

    render :action => "list"
  end

  def complete    
    @all_students = User.find(:all, :order => 'lastname ASC', :conditions => ['role_id = ?', 2])
    @students = User.paginate :page => params[:page], :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is not null and role_id = ?", 2 ]
		@export = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is not null and role_id = ?", 2 ]

    render :action => "list"
  end
  
	def print
		if @s = User.find(params[:id])
			@s.make_pdf
			@filename = "pdf/#{@s.firstname}-#{@s.lastname}-#{@s.token}.pdf"
		end
    render :update do |page|
      page[:overlay].show
      page[:opaque_overlay].show
      page[:wait_box].hide
      page[:print_download].replace_html :partial => "print_download"
      page[:print_download].show
    end
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
			render :action => "list"
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
    @spreadsheet_file = "#{RAILS_ROOT}/public/spreadsheets/#{(params[:status] || params[:prev_action])}_applicants_#{Date.today}_#{Time.now.strftime("%H-%M_%p")}.xls"
    workbook = Spreadsheet::Workbook.new # Spreadsheet.open(spreadsheet_dir+spreadsheet_file)
    worksheet = workbook.create_worksheet :name => "Applicant Data"
    
    # create styles
    page_title_format = Spreadsheet::Format.new( :color => "black", :bold => true, :size => 30 )
    header_format = Spreadsheet::Format.new( :color => "black", :bold => true, :size => 12 )
    data_format = Spreadsheet::Format.new( :color => "black", :bold => true, :size => 10 )
    workbook.default_format = data_format
    
    # setup headers
    worksheet.row(0).default_format = page_title_format
    worksheet[0,0] = "#{Time.now.year} NSFREU Applicant Data" 
    worksheet.row(1).default_format = header_format
    worksheet.row(1).concat %w{ID Name Email Gender Race Ethnicity Disability Current\ University Academic\ Year Major/Minor GPA Recommender\ Name Recommender\ Association Overall\ Promise Undergrad\ Institution?}
    worksheet.row(1).default_format = header_format

    # get applicant data
		case params[:prev_action]
		when "incomplete"
		  logger.info "exporting incomplete applicants"
			@applicants = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is ? and role_id = ?", nil, 2 ], :include => [ :academic_record, :recommender, :recommendation ]
		when "submitted"
			@applicants = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is null and role_id = ?", 2 ], :include => [ :academic_record, :recommender, :recommendation ]
		when "complete"
			@applicants = User.all :order => 'lastname ASC', :conditions => [ "submitted_at is not null and completed_at is not null and role_id = ?", 2 ], :include => [ :academic_record, :recommender, :recommendation ]
		when "total"
			@applicants = User.all :order => 'lastname ASC', :conditions => ['role_id = ?', 2], :include => [ :academic_record, :recommender, :recommendation ]
		else
			case params[:status]
			when "Accept"
				@applicants = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'Accept',  2 ], :include => [ :academic_record, :recommender, :recommendation ]
			when "In Review"
		    @applicants = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'In Review', 2 ], :include => [ :academic_record, :recommender, :recommendation ]
			when "Waitlist"
				@applicants = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'Waitlist',  2 ], :include => [ :academic_record, :recommender, :recommendation ]
			when "Reject"
		    @applicants = User.all :order => 'lastname ASC', :conditions => [ "status = ? and role_id = ?", 'Reject',  2 ], :include => [ :academic_record, :recommender, :recommendation ]
			else
		    @applicants = User.all :order => 'lastname ASC', :conditions => ['role_id = ?', 2], :include => [ :academic_record, :recommender, :recommendation ]
			end
		end
    
    # iterate over each applicant
    # @applicants.each_with_index do |a,i|
    @row = 1
    @applicants.each do |a|
      @row += 1
      worksheet.row(@row).concat [a.id, 
				"#{a.firstname} #{a.lastname}", 
				a.email, 
				a.gender, 
				a.race, 
				a.ethnicity, 
				a.disability, 
				(a.academic_record.college if a.academic_record), 
				(a.academic_record.college_level if a.academic_record), 
				(a.academic_record.major if a.academic_record), 
				(a.academic_record.gpa if a.academic_record), 
				(a.recommender.name if a.recommender), 
				(("#{a.recommender.department} / #{a.recommender.college}") if a.recommender), 
				(a.recommendation.rating if a.recommendation), 
				(a.recommendation.undergrad_inst if a.recommendation)]
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
  
  def reset_db
    if request.post? 
      if params[:delete] == 'delete'
        system "cd #{RAILS_ROOT} && bundle exec rake db:migrate:reset RAILS_ENV='production' && bundle exec rake db:seed RAILS_ENV='production';touch tmp/restart.txt;"
        flash[:succes] = "Database wiped.  You may need to restart your web server for the changes to take effect."
        redirect_to admin_path
      else
        flash[:error] = "There was some sort of problem. Try again."
        redirect_to reset_db_path
      end
    end
  end
  
  protected
  def expunge_excel_files
    Dir["#{RAILS_ROOT}/public/spreadsheets/*"].each {|f| File.delete f} if File.exist?("#{RAILS_ROOT}/public/spreadsheets")
  end
  
end