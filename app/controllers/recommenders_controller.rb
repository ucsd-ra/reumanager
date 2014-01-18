class RecommendersController < ApplicationController
  before_filter :login_from_cookie, :login_required, :application_complete?
#  ssl_required :index, :new, :edit, :create, :update, :destroy  
  
  # GET /recommenders
  # GET /recommenders.xml
  def index
    current_user.recommender ? redirect_to(:action => "edit") : redirect_to(:action => "new")
  end

  # GET /recommenders/new
  # GET /recommenders/new.xml
  def new
    @recommender = Recommender.new
    @recommender.user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recommender }
    end
  end

  # GET /recommenders/1/edit
  def edit
    @recommender = Recommender.find(current_user.recommender)
  end

  # POST /recommenders
  # POST /recommenders.xml
  def create
    # strip trailing whitespace from email input
    params[:recommender][:email] = params[:recommender][:email].strip
    @recommender = Recommender.new(params[:recommender])
    @recommender.user_id = current_user.id
    respond_to do |format|
      if @recommender.save
        flash[:notice] = 'Recommender was successfully created.'
        format.html { redirect_to( :controller => "second_recommenders", :action => "new" ) }
        format.xml  { render :xml => @recommender, :status => :created, :location => @recommender }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recommender.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recommenders/1
  # PUT /recommenders/1.xml
  def update
    # strip trailing whitespace from email input
    @recommender = Recommender.find(current_user.recommender)
    params[:recommender][:email] = params[:recommender][:email].strip

    respond_to do |format|
      if @recommender.update_attributes(params[:recommender])
        flash[:notice] = 'Recommender was successfully updated.'
        format.html { redirect_to( :controller => "second_recommenders", :action => "new" ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recommender.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recommenders/1
  # DELETE /recommenders/1.xml
#  def destroy
#    @recommender = Recommender.find(params[:id])
#    @recommender.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(recommenders_url) }
#      format.xml  { head :ok }
#    end
#  end
end
