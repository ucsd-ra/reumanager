class AcademicRecordsController < ApplicationController
  before_filter :login_from_cookie, :login_required
  
  # GET /academic_records
  # GET /academic_records.xml
  def index
    if current_user && current_user.submit_date      
      flash[:notice] = 'You can no longer edit your application.'
      redirect_to "/status"
    else
      current_user.academic_record ? redirect_to(:action => "edit") : redirect_to(:action => "new") 
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
    if current_user
      @academic_record = AcademicRecord.new
    else
        redirect_to("/login")
    end
  end

  # GET /academic_records/1/edit
  def edit
    if current_user
      redirect_to(:action => "new") unless @academic_record = AcademicRecord.find_by_user_id(current_user.id)
    else
      redirect_to("/login")
    end
  end

  # POST /academic_records
  # POST /academic_records.xml
  def create
    @academic_record = AcademicRecord.new(params[:academic_record]) || AcademicRecord.new
    @academic_record.user_id = current_user.id
    if params[:transcript_file] != ""
      Transcript.transaction do
        current_user.transcript.destroy if current_user.transcript
        current_user.transcript = Transcript.new( :uploaded_data => params[:transcript_file] )
        current_user.transcript.save
      end
    end
      respond_to do |format|
        if current_user.transcript && current_user.transcript.save! && @academic_record.save
          flash[:notice] = 'Academic information was successfully created'
          format.html { redirect_to( :controller => "recommenders" ) }
          format.xml  { render :xml => @academic_record, :status => :created, :location => @academic_record }
        else
          current_user.academic_record.destroy if current_user.academic_record
          unless current_user.transcript
            @academic_record.errors.add_to_base "You must upload copy of your most recent transcript."
          end
          format.html { render :action => "new" }
          format.xml  { render :xml => @academic_record.errors, :status => :unprocessable_entity }
        end
      end
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = 'There was an error with your form.'
    render :action => "new"
  end

  # PUT /academic_records/1
  # PUT /academic_records/1.xml
  def update
    @academic_record = AcademicRecord.find_by_user_id(current_user.id)
    if params[:transcript_file] != ""
      current_user.transcript.destroy if current_user.transcript
      current_user.transcript = Transcript.new(:uploaded_data => params[:transcript_file])
      current_user.transcript.save
    end
    respond_to do |format|
      if current_user.transcript && current_user.transcript.save! && @academic_record.update_attributes(params[:academic_record]) 
        flash[:notice] = 'Academic information was successfully updated'
        format.html { redirect_to( :action => "edit" ) }
        format.xml  { head :ok }
      else
        unless current_user.transcript
          @academic_record.errors.add_to_base "You must upload copy of your most recent transcript."
        end
        format.html { render :action => "edit" }
        format.xml  { render :xml => @academic_record.errors, :status => :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = 'Transcript must be in PDF format'
    render :action => "edit"
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
    if params[:prev_college] == "Yes"
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"          
        page[:pcollege].show
      end
    else
      render :update do |page|
        page[:observers].replace_html :partial => "layouts/observers"
        page[:pcollege].hide
      end
    end
  end
end
