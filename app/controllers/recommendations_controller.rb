class RecommendationsController < ApplicationController
#  ssl_required :index, :new, :edit, :create, :update

  # GET /recommendations
  # GET /recommendations.xml
  def index
    current_user.recommender ? redirect_to(:action => "edit") : redirect_to(:action => "new") 
  end

  # GET /recommendations/new
  # GET /recommendations/new.xml
  def new
    if @user = User.find_by_token(params[:id])
      @recommendation = Recommendation.new
      
      @recommender = Recommender.find(@user.recommender)
      
      if @recommender.recommendation
         redirect_to :action => :edit, :token => params[:id]
      else
        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @recommendation }
        end
      end
    else
      redirect_to :action => "sorry"
    end
  end

  # GET /recommendations/1/edit
  def edit
    if @user = User.find_by_token(params[:token])
      @recommendation = Recommendation.find_by_user_id(@user)
    else
      redirect_to :action => "sorry"
    end
  end

  # POST /recommendations
  # POST /recommendations.xml
  def create
    @recommendation = Recommendation.new(params[:recommendation])
    @user = User.find_by_token(params[:id])
    @recommendation.user_id = @user.id
    @recommendation.recommender_id = @user.recommender.id

    respond_to do |format|
      if @user.recommender.update_attributes(params[:recommender]) && @recommendation.save
        flash[:notice] = 'Recommendation was successfully created.'
        format.html { redirect_to( rec_thanks_url ) }
        format.xml  { render :xml => @recommendation, :status => :created, :location => @recommendation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recommendation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recommendations/1
  # PUT /recommendations/1.xml
  def update
    if @user = User.find_by_token(params[:id])
      @recommendation = Recommendation.find_by_user_id(@user)

      respond_to do |format|
        if @recommendation.update_attributes(params[:recommendation])
          flash[:notice] = 'Recommendation was successfully updated.'
          format.html { redirect_to(rec_thanks_url) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @recommendation.errors, :status => :unprocessable_entity }
        end
      end

    else
      redirect_to :action => "sorry"
    end

  end

  # DELETE /recommendations/1
  # DELETE /recommendations/1.xml
#  def destroy
#    @recommendation = Recommendation.find(params[:id])
#    @recommendation.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(recommendations_url) }
#      format.xml  { head :ok }
#    end
#  end
end
