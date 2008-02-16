class Student < ActiveRecord::Base
  belongs_to                :recommender
  validates_presence_of     :firstname, :lastname, :street, :city, :state, :zip, :phone, :email, :citizenship, :college, :college_start, :college_end, :college_level, :major, :gpa, :gpa_range, :personal_statement
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end