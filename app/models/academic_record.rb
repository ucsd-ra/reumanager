class AcademicRecord < ActiveRecord::Base
  belongs_to  :user
  has_attached_file         :transcript
  
  validates_attachment_presence :transcript
  validates_attachment_size :transcript, :less_than => 10.megabytes
  validates_presence_of     :college, :college_start, :college_end, :college_level, :major, :gpa, :gpa_range
  before_create :randomize_file_name

  private
  def randomize_file_name
    extension = File.extname(transcript_file_name).downcase
    self.transcript.instance_write(:file_name, "#{self.user.id}_#{ActiveSupport::SecureRandom.hex(24)}#{extension}")
  end
end
