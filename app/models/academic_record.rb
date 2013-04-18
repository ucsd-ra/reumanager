class AcademicRecord < ActiveRecord::Base
  attr_accessible :academic_level, :degree, :finish, :gpa, :gpa_comment, :gpa_range, :start, :university
  belongs_to :applicant, :class_name => "Applicant", :foreign_key => "applicant_id"
  
  validates :university, :presence => true
  validates :degree, :presence => true
  validates :start, :presence => true
  validates :finish, :presence => true
  validates :gpa, :presence => true
  validates :gpa_range, :presence => true
end
