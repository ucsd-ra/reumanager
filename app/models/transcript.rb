class Transcript < ActiveRecord::Base
  belongs_to                :user
  has_attachment            :content_type => ["application/pdf", "application/octet-stream"], :storage => :file_system, :max_size => 20.megabytes
  validates_as_attachment
end
