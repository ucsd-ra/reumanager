class Address < ActiveRecord::Base
  attr_accessible :address, :address2, :city, :country, :label, :permanent, :state, :zip
  belongs_to :applicant, :class_name => "Applicant", :foreign_key => "applicant_id"
  
  validates :label,  :inclusion => { :in => %w( Home School Other ) }
  validates :city,  :presence => true
  validates :state,  :presence => true
  validates :zip,  :presence => true
  validates :permanent,  :inclusion => { :in => ["Yes", "No"] }
end
