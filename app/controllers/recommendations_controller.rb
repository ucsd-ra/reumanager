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
    token = params[:id]

    if @user = User.find_by_token(token)
      Recommender.find_by_email(params[:email]) ? @recommender = Recommender.find_by_email(params[:email]) : @recommender = SecondRecommender.find_by_email(params[:email])

      @recommendation = @user.recommendations.build(:recommender_id => @recommender)

      if @user.recommendations.include?(@recommender.recommendation)
         redirect_to :action => :edit, :token => params[:id], :email => @recommender.email
      else
        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @recommendation }
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
    Recommender.find_by_email(params[:email]) ? @recommender = Recommender.find_by_email(params[:email]) : @recommender = SecondRecommender.find_by_email(params[:email])
    @user = User.find_by_token(token)
    @recommendation = Recommendation.find_by_recommender_id_and_user_id(@recommender, @user)
    @recommender = @recommendation.recommender
  end

  # POST /recommendations
  # POST /recommendations.xml
  def create
    @user = User.find_by_token(params[:id])
    Recommender.find_by_email(params[:recommender][:email]) ? @recommender = Recommender.find_by_email(params[:recommender][:email]) : @recommender = SecondRecommender.find_by_email(params[:recommender][:email])
    @recommendation = @user.recommendations.build(params[:recommendation])
    @recommendation.recommender_id = @recommender
    
    respond_to do |format|
      if @recommendation.save
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
