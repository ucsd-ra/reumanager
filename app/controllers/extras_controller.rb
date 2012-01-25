class ExtrasController < ApplicationController
  before_filter :login_from_cookie, :login_required, :application_complete?
#  ssl_required :index, :new, :edit, :create, :update
  
  def index
    if current_user.submitted_at && !is_admin
      flash[:notice] = 'You can no longer edit your application.'
      redirect_to(:controller => "users", :action => "status")
    else
      current_user.extra ? redirect_to(:action => "edit", :id => params[:id] || nil) : redirect_to(:action => "new")
    end
    
  end
  
  # GET /extras/new
  # GET /extras/new.xml
  def new
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id) if @id
    @extra = Extra.new
      
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @extra }
    end
  end

  # GET /extras/1/edit
  def edit    
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    @extra = Extra.find_by_user_id(@id)
  end

  # POST /extras
  # POST /extras.xml
  def create
    current_user.role.name == "admin" ? @id = params[:id] : @id = current_user.id
    @user = User.find(@id)
    
    @extra = Extra.new(params[:extra])
    @extra.user_id = current_user.id

    respond_to do |format|
      if @extra.save
        flash[:notice] = 'Additional information was successfully created.'
        format.html { redirect_to( :controller => "recommenders" ) }
        format.xml  { render :xml => @extra, :status => :created, :location => @extra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @extra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /extras/1
  # PUT /extras/1.xml
  def update
    @extra = Extra.find_by_user_id(current_user.id)

    respond_to do |format|
      if @extra.update_attributes(params[:extra])
        flash[:notice] = 'Additional information was successfully updated.'
        format.html { redirect_to( :controller => "recommenders" ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @extra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /extras/1
  # DELETE /extras/1.xml
#  def destroy
#    @extra = Extra.find(params[:id])
#    @extra.destroy
#
#   respond_to do |format|
#      format.html { redirect_to(extras_url) }
#      format.xml  { head :ok }
#    end
#  end

  def mentor
    id = params.keys.select {|k| k.include? "men"}.join.last
    value = params["mentor#{id}"]
    
    render :update do |page|
      if value == "Other"
        page["extra_mentor#{id}"].replace :partial => "mentor_input", :locals => {:id => id}
        page[:mentor_observers].replace :partial => "mentor_observers"
      end
    end
  end
  
  def restore_mentor_select
    id = params[:id]
    
    render :update do |page|
      page["extra_mentor#{id}"].replace :partial => "mentor_select", :locals => {:id => id}
      page["cancel_extra_mentor#{id}"].remove
      page[:mentor_observers].replace :partial => "mentor_observers"
    end
    
  end
end
