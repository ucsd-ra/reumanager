class Student < ActiveRecord::Base
  validates_presence_of     :firstname, :middlename, :lastname, :street, :city, :state, :zip, :phone, :email, :citizenship, :college, :cstart, :cend, :major, :gpa, :gpa_total 
end
