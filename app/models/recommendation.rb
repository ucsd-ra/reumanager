class Recommendation < ActiveRecord::Base
  belongs_to                :student
  validates_presence_of     :known_student, :know_capacity, :rating, :gpa, :gpa_total, :undergrad_inst, :factulty_comment
end
