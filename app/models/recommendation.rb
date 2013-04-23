class Recommendation < ActiveRecord::Base
  attr_accessible :applicant_id, :body, :known_applicant_for, :known_capacity, :overall_promise, :recommender_id, :undergraduate_institution

  belongs_to :applicant, :class_name => "Applicant"
  belongs_to :recommender, :class_name => "Recommender"

  validates_presence_of :body, :on => :update
  validates_presence_of :known_applicant_for, :on => :update
  validates_presence_of :known_capacity, :on => :update
  validates_presence_of :overall_promise, :on => :update

  validates_presence_of :applicant
  validates_presence_of :recommender
  
  before_create :make_token
  after_destroy :remove_orphaned_recommenders
  
  private
  
  def remove_orphaned_recommenders
    recommender = Recommender.find_by_email(self.recommender.email)
    recommender.destroy if recommender.recommendations.empty?
  end
  
  def make_token
    self.token = "#{Digest::MD5.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join)}-#{Digest::MD5.hexdigest((Time.now - 30.days).to_s.split(//).sort_by{rand}.join)}"
    self.token_created_at = Time.now
  end
  
  def received?
    true
  end
end
