class ExtrasController < ApplicationController
  
  def index
    current_user.extra ? redirect_to(:action => "edit") : redirect_to(:action => "new")
  end
  
  # GET /extras/new
  # GET /extras/new.xml
  def new
    @extra = Extra.new
    @extra.user_id = current_user.id
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @extra }
    end
  end

  # GET /extras/1/edit
  def edit
    @extra = Extra.find_by_user_id(current_user.id)
  end

  # POST /extras
  # POST /extras.xml
  def create
    @extra = Extra.new(params[:extra])
    @extra.user_id = current_user.id

    respond_to do |format|
      if @extra.save
        flash[:notice] = 'Additional information was successfully created.'
        format.html { redirect_to( :action => "edit" ) }
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
        format.html { redirect_to( :action => "edit" ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @extra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /extras/1
  # DELETE /extras/1.xml
  def destroy
    @extra = Extra.find(params[:id])
    @extra.destroy

    respond_to do |format|
      format.html { redirect_to(extras_url) }
      format.xml  { head :ok }
    end
  end
end
