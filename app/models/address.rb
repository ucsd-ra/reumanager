class Address < ApplicationRecord
  attr_accessible :address, :address2, :city, :country, :label, :permanent, :state, :zip
  belongs_to :applicant, :class_name => "Applicant", :foreign_key => "applicant_id"

  validates :address,  :presence => true
  validates :label,  :inclusion => { :in => %w( Home School Other ) }
  validates :city,  :presence => true
  validates :state,  :presence => true
  validates :zip,  :presence => true
  validates :permanent,  :inclusion => { :in => ["Yes", "No"] }

  def to_s
    "#{self.address},#{' ' + self.address2 + ',' if self.address2} #{self.city}, #{self.state} #{self.zip}"
  end
end
