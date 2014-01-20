class RecommendersController < ApplicationController
  before_filter :login_from_cookie, :login_required, :application_complete?
#  ssl_required :index, :new, :edit, :create, :update, :destroy  
  
  # GET /recommenders
  # GET /recommenders.xml
  def index
    if params[:primary]
      current_user.primary_recommender? ? redirect_to(:action => "edit", :primary => true) : redirect_to(:action => "new", :primary => true)
    else
      current_user.secondary_recommender? ? redirect_to(:action => "edit", :primary => false) : redirect_to(:action => "new", :primary => false)
    end
  end

  # GET /recommenders/new
  # GET /recommenders/new.xml
  def new
    if params[:primary]
      @recommender = current_user.recommenders.build(:primary => true)
    else
      @recommender = current_user.recommenders.build(:primary => false)
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /recommenders/1/edit
  def edit
    if params[:primary]
      @recommender = current_user.primary_recommender
    else
      @recommender = current_user.secondary_recommender
    end
  end

  # POST /recommenders
  # POST /recommenders.xml
  def create
    @recommender = Recommender.new(params[:recommender])
    @recommender.user_id = current_user.id

    respond_to do |format|
      if @recommender.save
        flash[:notice] = 'Recommender was successfully created.'
        logger.info "recommender created, primary params: #{params[:recommender][:primary]}" 
        if params[:recommender][:primary] == 'true'
          format.html { redirect_to( :controller => "recommenders", :primary => false ) }
        else
          format.html { redirect_to( :controller => "users", :action => "submit") }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /recommenders/1
  # PUT /recommenders/1.xml
  def update
    if params[:recommender][:primary] == 'true'
      @recommender = Recommender.find(current_user.primary_recommender)
    else
      @recommender = Recommender.find(current_user.secondary_recommender)
    end

    respond_to do |format|
      if @recommender.update_attributes(params[:recommender])
        flash[:notice] = 'Recommender was successfully updated.'
        format.html { redirect_to( :controller => "recommenders", :primary => params[:recommender][:primary] ) }
      else
        format.html { render :action => "edit" }
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
