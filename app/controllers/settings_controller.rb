class SettingsController < ApplicationController
  def index
    @grant = current_grant
    @settings = Setting.all
  end

  def create
    if current_grant.update_attributes(grant_params)
      redirect_to settings_path, notice: 'You are all champions' # TODO less sarcastic message here
    else
      render :index
    end
  end

  protected

  def grant_params
    params.require(:grant)
      .permit(:settings_attributes => [:id, :value])
  end
end
