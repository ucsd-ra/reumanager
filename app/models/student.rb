class Student < ActiveRecord::Base
  validates_presence_of     :firstname, :middlename, :lastname, :street, :city, :state, :zip, :phone, :email, :citizenship, :college, :college_start, :college_end, :college_level, :major, :gpa, :gpa_range 
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
