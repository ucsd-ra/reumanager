class Award < ApplicationRecord
  attr_accessible :date, :description, :title

  belongs_to :applicant, :class_name => "Applicant", :foreign_key => "applicant_id"

  validates :title, :presence => true

  def to_s
    "#{self.title} - #{self.description}"
  end
end
