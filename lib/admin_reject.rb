require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class Reject < RailsAdmin::Config::Actions::Base
         RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

       register_instance_option :http_methods do
          [:get, :put]
        end

        register_instance_option :controller do
          Proc.new do
            @object.state = 'rejected'
            @object.save!
            respond_to do |format|
              format.html { redirect_to_on_success }
              format.js { render :json => { :id => @object.id.to_s, :label => @model_config.with(:object => @object).object_label } }
            end
          end
        end

        register_instance_option :link_icon do
          'icon-remove-sign'
        end

      end
    end
  end
end
