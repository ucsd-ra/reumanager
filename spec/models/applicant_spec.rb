require 'spec_helper'

describe Applicant do

  describe 'states' do
    before { @applicant = FactoryGirl.create(:applicant) }

    it "starts in the 'applied' state" do
      expect(@applicant.state).to eq('applied')
    end

    it "transitions to the 'completed_personal_info' state with valid personal info" do
      @applicant.update_attributes( addresses_attributes: {'0' => FactoryGirl.attributes_for(:address)}, statement: Faker::Lorem.sentences(4).join(' '))
      @applicant.set_state

      expect(@applicant.state).to eq('completed_personal_info')
    end

    it "transitions back to 'applied' when a required personal info attribute is removed" do
      @applicant.update_attributes( addresses_attributes: {'0' => FactoryGirl.attributes_for(:address)}, statement: nil)
      @applicant.set_state

      expect(@applicant.state).to eq('applied')
    end

    it "transitions to the 'completed_academic_info' state with valid personal info & valid academic record info" do
      @applicant.update_attributes statement: Faker::Lorem.sentences(4).join(' '),
        addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) },
        records_attributes: { '0' => FactoryGirl.attributes_for(:academic_record) }
      @applicant.set_state

      expect(@applicant.state).to eq('completed_academic_info')
    end

    it "transitions back to 'completed_personal_info' when a required academic info attribute is removed" do
      @applicant.update_attributes statement: Faker::Lorem.sentences(4).join(' '),
        addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) }
      @applicant.set_state

      expect(@applicant.state).to eq('completed_personal_info')
    end

    it "transitions to the 'completed_recommender_info' state with valid personal info, valid academic record info, & valid recommender info" do
      @applicant.update_attributes statement: Faker::Lorem.sentences(4).join(' '),
        addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) },
        records_attributes: { '0' => FactoryGirl.attributes_for(:academic_record) },
        recommenders_attributes: { '0' => FactoryGirl.attributes_for(:recommender) }
      @applicant.set_state

      expect(@applicant.state).to eq('completed_recommender_info')
    end

    it "transitions back to 'completed_academic_info' when a required recommender info attribute is removed" do
      @applicant.update_attributes statement: Faker::Lorem.sentences(4).join(' '),
        addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) },
        records_attributes: { '0' => FactoryGirl.attributes_for(:academic_record) }
      @applicant.set_state

      expect(@applicant.state).to eq('completed_academic_info')
    end

    it "transitions to the 'submitted' state with valid attributes when the .submit_application method is called" do
      @applicant.update_attributes statement: Faker::Lorem.sentences(4).join(' '),
        addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) },
        records_attributes: { '0' => FactoryGirl.attributes_for(:academic_record) },
        recommenders_attributes: { '0' => FactoryGirl.attributes_for(:recommender) }
      @applicant.submit_application

      expect(@applicant.state).to eq('submitted')
    end

    it "transitions back to 'completed_academic_info' and resets submitted_at to nil when a recommender has been removed or modified on a submitted application" do
      @applicant.update_attributes statement: Faker::Lorem.sentences(4).join(' '),
        addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) },
        records_attributes: { '0' => FactoryGirl.attributes_for(:academic_record) },
        recommenders_attributes: { '0' => FactoryGirl.attributes_for(:recommender) }
      @applicant.submit_application
      expect(@applicant.state).to eq('submitted')

      @applicant.recommenders.first.destroy
      @applicant.reload
      @applicant.set_state

      expect(@applicant.state).to eq('completed_academic_info')
    end

    it "transitions to the 'complete' state with valid attributes and a valid recommendation" do
      @applicant.update_attributes statement: Faker::Lorem.sentences(4).join(' '),
        addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) },
        records_attributes: { '0' => FactoryGirl.attributes_for(:academic_record) },
        recommenders_attributes: { '0' => FactoryGirl.attributes_for(:recommender) }
      @applicant.submit_application
      @applicant.recommendation.update_attributes FactoryGirl.attributes_for(:recommendation, recommender_id: @applicant.recommender.id)
      @applicant.set_state

      expect(@applicant.state).to eq('complete')
    end

  end

end
