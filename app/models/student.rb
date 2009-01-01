require 'digest/sha1'
require 'pdf/writer'
class Student < ActiveRecord::Base
  belongs_to                :user
  validates_presence_of     :firstname, :lastname, :dob, :street, :city, :state, :zip, :phone, :email, :citizenship

  

  after_create  :send_confirmation
 
 protected 

  
end