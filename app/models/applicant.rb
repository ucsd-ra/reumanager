class Applicant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, and :omniauthable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable, :confirmable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :dob, :citizenship, :disability, :gender, :ethnicity, :race, :cpu_skills, :gpa_comment, :lab_skills, :addresses_attributes, :awards_attributes, :records_attributes, :recommendations_attributes, :recommenders_attributes, :statement, :recommenders
  
  has_many :addresses, :class_name => "Address", :dependent => :destroy
  has_many :records, :class_name => "AcademicRecord", :dependent => :destroy
  has_many :awards, :class_name => "Award", :dependent => :destroy
  has_many :recommendations, :dependent => :destroy
  has_many :recommenders, :through => :recommendations,  :dependent => :restrict
  
  validates_associated :addresses, :awards, :records, :recommenders
  
  accepts_nested_attributes_for :addresses, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :awards, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :records, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :recommendations, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  accepts_nested_attributes_for :recommenders, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  
#  validates_presence_of :records, :if => :academic_records_controller?
  
#  validate :must_have_academic_record, :if => :academic_records_controller?
  scope :applied, -> { with_state(:applied) }
  scope :personal_info, -> { with_state(:personal_info) }
  scope :academic_info, -> { with_state(:academic_info) }  
  scope :recommended, -> { with_state(:recommended) }

  scope :complete, -> { with_state(:complete) }
  scope :incomplete, -> { with_state(:incomplete) }

  scope :withdrawn, -> { with_state(:withdrawn) }
  scope :accepted, -> { with_state(:accepted) }
  scope :rejected, -> { with_state(:rejected) } 
  
  rails_admin do
    label "List of applicants"
  end

  state_machine :initial => :applied do

    # confirmed
    # personal info
      # location_added
      # peresonal statement
    # academic info
      # academic record
      # awards
      # cpu_skills
      # lab_skills
    # recommender
    # submit
    # recommended (before/aft deadline)
    # complete/incomplete (after deadline)
    # withdrawn/accepted/rejected

    # StateMachine State method definitions. Here we provide a unique
    # redirect_url for each state
    state :applied do
      def redirect_url
        Rails.application.routes.url_helpers.edit_applicant_registration_url(:only_path => true)
      end
    end

    state :completed_personal_info do
      def redirect_url
        Rails.application.routes.url_helpers.applicants_records_url(:only_path => true)
      end
    end

    state :completed_academic_info do
      def redirect_url
        Rails.application.routes.url_helpers.applicants_recommenders_url(:only_path => true)
      end
    end

    state :completed_recommender_info do
      def redirect_url
        Rails.application.routes.url_helpers.applicant_status_url(:only_path => true)
      end
    end

    state :submitted do
      def redirect_url
        Rails.application.routes.url_helpers.applicant_status_url(:only_path => true)
      end
    end
    
    state :complete do
      def redirect_url
        Rails.application.routes.url_helpers.applicant_status_url(:only_path => true)
      end
    end

    # StateMachine Event transitions
    event :complete_personal_info do
      transition all => :completed_personal_info, :if => lambda { |applicant| applicant.validates_personal_info }
    end
    event :incomplete_personal_info do
      transition all => :applied
    end
    
    
    event :complete_academic_info do
      transition all => :completed_academic_info, :if => lambda { |applicant| applicant.validates_academic_info && applicant.validates_personal_info }
    end
    event :incomplete_academic_info do
      transition all => :completed_personal_info, :if => lambda { |applicant| !applicant.validates_academic_info && !applicant.validates_personal_info }
    end
    
    
    event :complete_recommender_info do
      transition all => :completed_recommender_info, :if => lambda { |applicant| applicant.validates_academic_info && applicant.validates_personal_info && applicant.validates_recommender_info }
    end
    event :incomplete_recommender_info do
      transition all => :completed_academic_info, :if => lambda { |applicant| !applicant.validates_recommender_info }
    end
    
    
    event :submit_application do
      transition all => :submitted, :if => lambda { |applicant| applicant.validates_application_completeness }
    end
    
    after_transition :on => :submit_application, :do => :submit_application_callbacks
    
    event :unsubmit_application do
      transition all => :completed_recommender_info, :if => lambda { |applicant| !applicant.validates_application_completeness }
    end

    after_transition :on => :unsubmit_application, :do => lambda { |applicant| applicant.update_attribute :submitted_at, nil }
      
    event :recommendation_recieved do
      transition :submitted => :complete, :if => lambda { |applicant| applicant.submitted? }
    end

    after_transition :on => :recommendation_recieved, :do => :complete_application!
    
    event :missed_deadline do
      transition all => :incomplete
    end

    event :withdraw do
      transition all => :withdrawn
    end
    
    event :reject do
      transition all => :rejected
    end
    
    event :accept do
      transition all => :accepted
    end
    
    
  end
    
  def complete_application!
    self.update_attribute :completed_at, Time.now
    Notification.recommendation_thanks(self.recommendation).deliver
    Notification.application_complete(self).deliver
  end
  
  def address
    self.addresses.first
  end  
  
  def name
    name = ""
    name += "#{self.first_name} #{self.last_name}"
  end

  def recommendation
    self.recommendations.last
  end
  
  def recommender
    self.recommenders.last
  end
  
  def validates_personal_info
    validates_presence_of :addresses, :message => "can't be blank.  Please add at least one address to your profile."
    validates_presence_of :phone, :message => "can't be blank. Please add at least one phone number to your profile."
    validates_presence_of :statement, :message => "can't be blank. Please add at least one phone number to your profile."
    return true if self.errors.empty?
  end

  def validates_academic_info
    validates_presence_of :records, :message => "can't be blank.  Please add at least one academic record."
    return true if self.errors.empty?
  end
  
  def validates_recommender_info
    validates_presence_of :recommenders, :message => "can't be blank.  Please add at least one recommender."
    return true if self.errors.empty?
  end
  
  def validates_application_completeness
    validates_personal_info && validates_academic_info && validates_recommender_info
  end
  
  def set_state
    case
    when !self.validates_personal_info
      self.incomplete_personal_info
    when !self.validates_academic_info
      self.incomplete_academic_info
    when !self.validates_recommender_info
      self.incomplete_recommender_info
    when !self.submitted_at
      self.complete_recommender_info
    when !self.completed_at
      self.recommendation_recieved
    else
      self.state
    end
  end
  
  def submit_application_callbacks
    self.update_attribute :submitted_at, Time.now

    Notification.application_submitted(self).deliver

    self.recommendations.each do |recommendation|
      Notification.recommendation_request(recommendation).deliver
    end
  end
  
end
