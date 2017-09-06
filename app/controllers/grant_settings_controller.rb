class GrantSettingsController < ApplicationController
  before_action :set_grant_setting, only: [:show, :edit, :update, :destroy]

  # GET /grant_settings
  def index
    @grant_settings = GrantSetting.all
  end

  # GET /grant_settings/1
  def show
  end

  # GET /grant_settings/new
  def new
    # @grant_name = Grant.find(params[:grant_id]).name
    @grant_setting = GrantSetting.new(grant_id: params[:grant_id])
    # the grant_id in the params[ ] has to match the name of the variable on the LEFT passed in  from the previous controller redirect_to new_grant_setting_path(grant_id: @grant.id)
    
  end

  # GET /grant_settings/1/edit
  def edit
  end

  # POST /grant_settings
  def create
 

    @grant_setting = GrantSetting.new(grant_setting_params)

    if @grant_setting.save

      # redirect_to @grant, notice: 'Grant was successfully created.'
      redirect_to new_grant_snippet_path(grant_id: @grant_setting.grant_id), notice: 'Your  settings were successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /grant_settings/1
  def update
    if @grant_setting.update(grant_setting_params)
      redirect_to @grant_setting, notice: 'Grant setting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /grant_settings/1
  def destroy
    @grant_setting.destroy
    redirect_to grant_settings_url, notice: 'Grant setting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant_setting
      @grant_setting = GrantSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grant_setting_params
      params.require(:grant_setting).permit(:institute, :department, :department_postal_address, :application_start, :application_deadline, :notification_date, :program_start_date, :program_end_date, :checkback_date, :mail_from, :funded_by, :main_url, :department_url, :program_url, :grant_id)
    end
end
