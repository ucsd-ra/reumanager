class SettingsController < ApplicationController
  def index
    @grant = current_grant
    @settings = Setting.all
  end

  def create
    if current_grant.update_attributes(grant_params)
      redirect_to snippets_url, notice: 'You have successfully updated your settings.' 
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
