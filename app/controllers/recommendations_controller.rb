class RecommendationsController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_from_cookie, :login_required, :except => [:new, :create, :no_student]
  
  # GET /recommendations
  # GET /recommendations.xml
  def index
    @recommendations = Recommendation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recommendations }
    end
  end

  # GET /recommendations/1
  # GET /recommendations/1.xml
  def show
    @recommendation = Recommendation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recommendation }
    end
  end

  # GET /recommendations/new
  # GET /recommendations/new.xml
  def new
    @recommendation = Recommendation.new
    @student = Student.find_by_token(params[:id])
    @recommender = Recommender.find(@student.recommender_id) if @student
    if @student
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @recommendation }
      end
    else
      redirect_to("http://be-webapps.ucsd.edu/test/recommend")
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to("http://be-webapps.ucsd.edu/test/recommend") 
  end

  # GET /recommendations/1/edit
  def edit
    @recommendation = Recommendation.find(params[:id])
  end

  # POST /recommendations
  # POST /recommendations.xml
  def create
    @recommendation = Recommendation.new(params[:recommendation])
    @student = Student.find(@recommendation.student_id)
    @recommender = Recommender.find(@student.recommender_id)
    @recommendation.recommender_id = @student.recommender_id
    
    respond_to do |format|
      if @recommendation.save
        flash[:notice] = 'Recommendation was successfully created.'
        format.html { redirect_to "http://be-webapps.ucsd.edu/test/thanks" }
        format.xml  { render :xml => @recommendation, :status => :created, :location => @recommendation }
      else
        format.html { render :action => "new", :id => @student.id }
        format.xml  { render :xml => @recommendation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recommendations/1
  # PUT /recommendations/1.xml
  def update
    @recommendation = Recommendation.find(params[:id])

    respond_to do |format|
      if @recommendation.update_attributes(params[:recommendation])
        flash[:notice] = 'Recommendation was successfully updated.'
        format.html { redirect_to(@recommendation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recommendation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recommendations/1
  # DELETE /recommendations/1.xml
  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.destroy

    respond_to do |format|
      format.html { redirect_to(recommendations_url) }
      format.xml  { head :ok }
    end
  end
  
end
