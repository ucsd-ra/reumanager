class Recommendation < ActiveRecord::Base
  attr_accessible :applicant_id, :body, :known_applicant_for, :known_capacity, :overall_promise, :recommender_id, :undergraduate_institution?

  belongs_to :applicant, :class_name => "Applicant"
  belongs_to :recommender, :class_name => "Recommender"

  after_destroy :remove_orphaned_recommenders
  
  private
  
  def remove_orphaned_recommenders
    recommender = Recommender.find_by_email(self.recommender.email)
    recommender.destroy if recommender.recommendations.empty?
  end
  
end
