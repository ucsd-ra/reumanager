class Recommender < ActiveRecord::Base
  attr_accessible :department, :email, :first_name, :last_name, :organization, :phone, :title, :url

  has_many :recommendations
  has_many :applicants, :through => :recommendations
  
  validates :first_name,  :presence => true
  validates :last_name,   :presence => true
  validates :email,   :presence => true
  validates :organization,   :presence => true
  validates :department,   :presence => true
  validates :title,   :presence => true
  

end
