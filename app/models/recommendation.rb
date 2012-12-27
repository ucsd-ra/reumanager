class Recommendation < ActiveRecord::Base
  attr_accessible :applicant_id, :body, :known_applicant_for, :known_capacity, :overall_promise, :recommender_id, :undergraduate_institution?

  belongs_to :applicant, :class_name => "Applicant"
  belongs_to :recommender, :class_name => "Recommender"
end
