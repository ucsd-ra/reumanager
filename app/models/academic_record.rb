class AcademicRecord < ActiveRecord::Base
  has_one     :transcript, :dependent => :destroy
  belongs_to  :user
  validates_presence_of     :college, :college_start, :college_end, :college_level, :major, :gpa, :gpa_range
end
