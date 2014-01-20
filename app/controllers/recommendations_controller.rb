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
      @recommender = Recommender.find_by_email(params[:email])
      @recommendation = @recommender.recommendations.build(:recommender_id => @recommender)

      if @recommender.recommendations(:where => {:user_id => @user}).first
         redirect_to :action => :edit, :token => params[:id], :email => @recommender.email
      else
        respond_to do |format|
          format.html # new.html.erb
        end
      end
    else
      redirect_to :action => "sorry"
    end

  rescue NoMethodError
    redirect_to :action => "sorry"
  end

  # GET /recommendations/1/edit
  def edit
    token = params[:token]
    @recommender = Recommender.find_by_email(params[:email])
    @user = User.find_by_token(token)
    @recommendation = @recommender.recommendations(:where => { :user_id => @user }).first
  end

  # POST /recommendations
  # POST /recommendations.xml
  def create
    @user = User.find_by_token(params[:id])
    @recommender = Recommender.find_by_email(params[:recommender][:email])
    @recommendation = @user.recommendations.build(params[:recommendation])
    @recommendation.recommender = @recommender
    
    respond_to do |format|
      if @recommendation.save
        flash[:notice] = 'Recommendation was successfully created.'
        format.html { redirect_to( rec_thanks_url ) }
      else
        format.html { render :action => "new" }
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
        else
          format.html { render :action => "edit" }
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
