class AcademicRecord < ActiveRecord::Base
  attr_accessible :academic_level, :degree, :finish, :gpa, :gpa_comment, :gpa_range, :start, :university
  belongs_to :applicant, :class_name => "Applicant", :foreign_key => "applicant_id"
  attr_accessible :transcript
  has_attached_file :transcript
  validates_attachment :transcript, :presence => true,
    content_type: { content_type: ['application/pdf','image/jpg', 'image/jpeg', 'image/gif', 'image/png'] },
    :size => { :in => 0..10.megabytes }

  validates :university, :presence => true
  validates :degree, :presence => true
  validates :start, :presence => true
  validates :finish, :presence => true
  validates :gpa, :presence => true
  validates :gpa_range, :presence => true

  def to_s
    record = "#{self.start.strftime("%Y.%m")} - #{self.finish.strftime("%Y.%m")}} studying #{self.degree} at #{self.university}"
    record << "\n#{Markdown.render "GPA Comment: " + self.gpa_comment}" if self.gpa_comment
  end

end
