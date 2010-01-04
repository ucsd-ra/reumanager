class Transcript < ActiveRecord::Base
  belongs_to                :user
  has_attachment            :storage => :file_system, :max_size => 20.megabytes
  validates_as_attachment
end
