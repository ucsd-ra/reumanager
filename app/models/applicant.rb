class Applicant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, and :omniauthable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable, :confirmable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :dob, :citizenship, :disability, :gender, :ethnicity, :race, :cpu_skills, :lab_skills, :addresses_attributes, :awards_attributes, :records_attributes, :recommendations_attributes, :recommenders_attributes
  
  has_many :addresses, :class_name => "Address", :dependent => :destroy
  has_many :records, :class_name => "AcademicRecord", :dependent => :destroy
  has_many :awards, :class_name => "Award", :dependent => :destroy
  has_many :recommendations
  has_many :recommenders, :through => :recommendations
  
  
  validates_associated :addresses, :awards, :records, :recommenders
  
  accepts_nested_attributes_for :addresses, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :awards, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :records, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :recommendations, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :recommenders, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  
  
  rails_admin do
    label "List of applicants"
  end
  
  def validates_application_completeness
    validates_presence_of :phone, :on => :update, :message => "can't be blank"
  end
  
end
