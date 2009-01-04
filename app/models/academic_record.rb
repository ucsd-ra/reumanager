class AcademicRecord < ActiveRecord::Base
  belongs_to  :user
  validates_presence_of     :college, :college_start, :college_end, :college_level, :major, :gpa, :gpa_range
end
