class AcademicRecordsController < ApplicationController
	before_filter :login_from_cookie, :login_required, :application_complete?
#	ssl_required :index, :show, :new, :edit, :create, :update, :destroy_transcript, :observe_pcollege
  
  # GET /academic_records
  # GET /academic_records.xml
  def index
    if current_user.role.name == "admin"
      @user = User.find(params[:id]) if params[:id]
      @user.academic_record ? redirect_to(:action => "edit", :id => params[:id] || nil ) : redirect_to(:action => "new", :id => @user) 
    else
      current_user.academic_record ? redirect_to(:action => "edit", :id => params[:id] || nil ) : redirect_to(:action => "new") 
    end
  end

  # GET /academic_records/1
  # GET /academic_records/1.xml
  def show
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @academic_record = AcademicRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @academic_record }
    end
  end

  # GET /academic_records/new
  # GET /academic_records/new.xml
  def new
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    @academic_record = @user.build_academic_record
  end

  # GET /academic_records/1/edit
  def edit
		if current_user
			current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
	    @user = User.find(@id)
			if @user
				@academic_record = AcademicRecord.find_by_user_id(current_user.id)
			else
				redirect_to login_path
			end
		else
			redirect_to login_path
		end
  end

  # POST /academic_records
  # POST /academic_records.xml
  def create
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    @user.build_academic_record params[:academic_record]
    @academic_record = @user.academic_record
    
    respond_to do |format|
      if @user.academic_record.save
        flash[:notice] = 'Academic information was successfully created'
        format.html { redirect_to( :controller => "extras" ) }
        format.xml  { render :xml => @user.academic_record, :status => :created, :location => @user.academic_record }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.academic_record.errors, :status => :unprocessable_entity }
      end
    end

  rescue RuntimeError => e
    logger.error 'Error with academic record upload - ' + e.message
    flash[:notice] = "There was an error with the form. Please save the acaemic info first before upload your transcript."
    redirect_to :action => 'new'
  end

  # PUT /academic_records/1
  # PUT /academic_records/1.xml
  def update
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    @academic_record = @user.academic_record
    
    if params[:p_college] == "No"
      params[:academic_record][:p_college] = ""
      params[:academic_record][:p_college_start] = nil
      params[:academic_record][:p_college_end] = nil
    end  
    respond_to do |format|
      if @academic_record.update_attributes(params[:academic_record]) 
        flash[:notice] = 'Academic information was successfully updated'
        format.html { redirect_to(:controller => "extras", :id => @id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @academic_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /academic_records/1
  # DELETE /academic_records/1.xml
#  def destroy
#    @academic_record = AcademicRecord.find(params[:id])
#    @academic_record.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(academic_records_url) }
#      format.xml  { head :ok }
#    end
#  end
  
  def observe_pcollege
    if params[:p_college] == "Yes"
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"          
        page[:pcollege].appear
      end
    else
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"
        page[:pcollege].hide
      end
    end
  end
  
end
