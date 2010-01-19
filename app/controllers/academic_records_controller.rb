class AcademicRecordsController < ApplicationController
  before_filter :login_from_cookie, :login_required
  ssl_required :index, :show, :new, :edit, :create, :update, :destroy_transcript, :observe_pcollege
  
  # GET /academic_records
  # GET /academic_records.xml
  def index
    if current_user.submitted_at && !is_admin
      flash[:notice] = 'You can no longer edit your application.'
      redirect_to(:controller => "users", :action => "status")
    else
      current_user.academic_record ? redirect_to(:action => "edit", :id => params[:id] || nil ) : redirect_to(:action => "new") 
    end
  end

  # GET /academic_records/1
  # GET /academic_records/1.xml
  def show
    @academic_record = AcademicRecord.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @academic_record }
    end
  end

  # GET /academic_records/new
  # GET /academic_records/new.xml
  def new
    @user = current_user unless current_user.role.name == 'admin'
    @academic_record = AcademicRecord.new
  end

  # GET /academic_records/1/edit
  def edit
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    @academic_record = AcademicRecord.find_by_user_id(current_user.id)
  end

  # POST /academic_records
  # POST /academic_records.xml
  def create
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    @academic_record = @AcademicRecord.new(params[:academic_record]) || AcademicRecord.new
    @academic_record.user_id = current_user.id
    if params[:transcript_file] != "" 
      Transcript.transaction do
        @user.transcript.destroy if @user.transcript
        @user.transcript = Transcript.new(:uploaded_data => params[:transcript_file])
        @user.transcript.save
      end
    end
    respond_to do |format|
      if @academic_record.save && @user.transcript && @user.transcript.save
        flash[:notice] = 'Academic information was successfully created'
        format.html { redirect_to( :controller => "extras" ) }
        format.xml  { render :xml => @academic_record, :status => :created, :location => @academic_record }
      else
        unless @user.transcript && @user.transcript.save
          @academic_record.errors.add_to_base "You must upload copy of your most recent transcript."
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @academic_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /academic_records/1
  # PUT /academic_records/1.xml
  def update
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    @academic_record = @user.academic_record
    if params[:transcript_file] && params[:transcript_file] != ""
      @user.transcript.destroy if @user.transcript
      @user.transcript = Transcript.new(:uploaded_data => params[:transcript_file])
      @user.transcript.save
    end  
    if params[:p_college] == "No"
      params[:academic_record][:p_college] = ""
      params[:academic_record][:p_college_start] = nil
      params[:academic_record][:p_college_end] = nil
    end  
    respond_to do |format|
      if @user.transcript && @user.transcript.save && @academic_record.update_attributes(params[:academic_record]) 
        flash[:notice] = 'Academic information was successfully updated'
        format.html { redirect_to(:controller => "extras", :id => @id) }
        format.xml  { head :ok }
      else
        unless @user.transcript
          @academic_record.errors.add_to_base "You must upload copy of your most recent transcript."
        end
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

  def destroy_transcript
    @academic_record = AcademicRecord.find(params[:id])
    @academic_record.destroy

    respond_to do |format|
      format.html { redirect_to(academic_records_url) }
      format.xml  { head :ok }
    end
  end
  
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
