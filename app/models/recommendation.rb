class Recommendation < ActiveRecord::Base
  belongs_to                :student
  belongs_to                :recommender
  validates_presence_of     :known_student, :know_capacity, :rating, :gpa, :gpa_range, :undergrad_inst, :faculty_comment
end
