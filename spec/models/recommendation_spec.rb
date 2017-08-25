require 'spec_helper'

describe Recommendation do

  # object instantiation
  it { should be_an_instance_of(Recommendation) }

  # association(s)
  it { should respond_to :applicant }
  it { should belong_to :applicant }
  it { should respond_to :recommender }
  it { should belong_to :recommender }

  it "is valid with the required attributes"  do
    recommendation = FactoryGirl.create(:recommendation_with_associations)
    expect(recommendation).to be_valid
  end

  %w{ body known_applicant_for known_capacity overall_promise}.each do |m|
    it "is INVALID without the required attribute '#{m}'"  do
      recommendation = FactoryGirl.create(:recommendation_with_associations, m.to_sym => nil)
      expect(recommendation).to be_invalid
    end
  end

  %w{ applicant_id recommender_id }.each do |relationship|
    it "is INVALID without the required #{relationship.gsub("_id",'')} relationship" do
      expect(FactoryGirl.build(:recommendation_with_associations, relationship.to_sym => nil)).to be_invalid
    end
  end

  it 'removes the orphaned recommender when deleted' do
    recommendation = FactoryGirl.create(:recommendation_with_associations)
    recommender = recommendation.recommender
    recommendation.destroy

    expect(Applicant.find_by_email(recommender.email)).to be_nil
  end

end
