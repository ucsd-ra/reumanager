Paperclip.interpolates :rails_relative_url_root  do |attachment, style|
  Rails.application.config.action_controller.relative_url_root.to_s
end
