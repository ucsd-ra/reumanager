class Recommendation < ApplicationRecord
  attr_accessible :applicant_id, :body, :known_applicant_for, :known_capacity, :overall_promise, :recommender_id, :recommender_attributes, :undergraduate_institution, :received_at

  belongs_to :applicant, :class_name => "Applicant"
  belongs_to :recommender, :class_name => "Recommender"
  accepts_nested_attributes_for :recommender

  validates_presence_of :body, :on => :update
  validates_presence_of :known_applicant_for, :on => :update
  validates_presence_of :known_capacity, :on => :update
  validates_presence_of :overall_promise, :on => :update, message: "can't be blank. Please select one of the following: Top 1%, Top 5%, Top 10%, Top 25%, average, below average"
  validates_presence_of :applicant
  validates_presence_of :recommender

  before_create :make_token
  after_update :send_thank_you
  after_destroy :remove_orphaned_recommenders

  # has the recommendation been received and made complete?
  def received?
    !self.received_at.nil?
  end

  def send_thank_you
    if received?
      Notification.recommendation_thanks(self).deliver
    end
  end


  # a recommendation request can be sent if one has not been made within the last 24 hours
  def requestable?
    return true if self.request_sent_at == nil || Time.now - self.request_sent_at > 24.hours
  end

  def known_applicant_for_enum
    ['<1 year', '1-2 years', '2-3 years', '3-4 years', '>4 years']
  end

  def known_applicant_for_text
    known_applicant_for_enum[known_applicant_for] if known_applicant_for
  end

  private

  def remove_orphaned_recommenders
    recommender = Recommender.find_by_email(self.recommender.email)
    recommender.destroy if recommender.recommendations.empty?
  end

  # generate a token to be used by recommenders to access recommedation form
  def make_token
    self.token = "#{Digest::MD5.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join)}-#{Digest::MD5.hexdigest((Time.now - 30.days).to_s.split(//).sort_by{rand}.join)}"
    self.token_created_at = Time.now
  end

end
