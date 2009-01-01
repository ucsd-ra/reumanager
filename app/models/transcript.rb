class Transcript < ActiveRecord::Base
  belongs_to                :user
  has_attachment            :content_type => "application/pdf", :storage => :file_system, :max_size => 5.megabytes
  validates_as_attachment
end
