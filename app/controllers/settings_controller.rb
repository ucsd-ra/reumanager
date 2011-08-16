class SettingsController < ApplicationController
  before_filter :login_from_cookie, :login_required, :check_admin

  # GET /settings
  # GET /settings.xml

  def index
    edit
    render :action => 'edit'
  end

  def edit
    if request.post? && params[:settings] && params[:settings].is_a?(Hash)
      settings = (params[:settings] || {}).dup.symbolize_keys

      params['date_settings'].each do |key, value|
        if key.include? '(1i)'
          key = key.gsub(/\(\di\)/,'')
          date = Date.civil(params['date_settings']["#{key}(1i)"].to_i,params['date_settings']["#{key}(2i)"].to_i,params['date_settings']["#{key}(3i)"].to_i)
          settings[key] = date.to_s
          logger.info "Setting for date_setting #{key} added to settings hash."
        end
      end

      params['datetime_settings'].each do |key, value|
        if key.include? '(4i)'
          key = key.gsub(/\(\di\)/,'')
          date = DateTime.civil(params['datetime_settings']["#{key}(1i)"].to_i,params['datetime_settings']["#{key}(2i)"].to_i,params['datetime_settings']["#{key}(3i)"].to_i,params['datetime_settings']["#{key}(4i)"].to_i,params['datetime_settings']["#{key}(5i)"].to_i)
          settings[key] = date.to_s
          logger.info "Setting for datetime_setting #{key} added to settings hash."
        end
      end
  

      settings.each do |name, value|
        # remove blank values in array settings
        value.delete_if {|v| v.blank? } if value.is_a?(Array)
        Setting[name] = value
        logger.info "Setting added for #{name}"
      end
      flash[:notice] = ('Settings updated successfully')
      redirect_to :action => 'edit'
    else
      
    end
  end

end
