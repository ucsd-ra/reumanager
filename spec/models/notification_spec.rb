require 'spec_helper'

describe Notification do
  context 'applicant submits application' do
    before do
      @applicant = FactoryGirl.create(:applicant, statement: Faker::Lorem.sentences(4).join(' '),
      addresses_attributes: { '0' => FactoryGirl.attributes_for(:address) },
      records_attributes: { '0' => FactoryGirl.attributes_for(:academic_record) },
      recommenders_attributes: { '0' => FactoryGirl.attributes_for(:recommender) } )
      @applicant.submit_application
    end

    describe '.application_submitted' do
      it "sends a recommendation request when the application is submitted" do
        confirmation_mail = ActionMailer::Base.deliveries[-2]
        expect(confirmation_mail.to.first).to eq(@applicant.email)
        expect(confirmation_mail.subject).to eq("REU application received for #{@applicant.name}")
      end
    end

    describe '.recommendation_request' do
      it "sends a recommendation request to the recommender when the application is submitted" do
        expect(last_email.to.first).to eq(@applicant.recommender.email)
        expect(last_email.subject).to eq("REU recommendation request for #{@applicant.name}")
      end
    end

    describe '.recommendation_follow_up_request' do
      it "sends a followup recommendation request to the recommender when requested" do
        pending

        expect(last_email.to.first).to eq(@applicant.recommender.email)
        expect(last_email.subject).to eq("REU recommendation request for #{@applicant.name}")
      end

      it "throttles the follow up request rate to one request per 24/hours" do
        pending
      end
    end

    describe '.recommendation_thanks' do
      it "sends a thank you email once the recommendation has been received" do
        @applicant.recommendation.update_attributes FactoryGirl.attributes_for(:recommendation, recommender_id: @applicant.recommender.id)
        @applicant.set_state

        thanks_mail = ActionMailer::Base.deliveries[-2]

        expect(thanks_mail.to.first).to eq(@applicant.recommender.email)
        expect(thanks_mail.subject).to eq("REU recommendation received for #{@applicant.name}")
      end
    end

    describe '.application_complete' do
      it "sends a confirmation to the applicant when the application is submitted" do
        @applicant.recommendation.update_attributes FactoryGirl.attributes_for(:recommendation, recommender_id: @applicant.recommender.id)
        @applicant.set_state

        expect(last_email.to.first).to eq(@applicant.email)
        expect(last_email.subject).to eq("REU application complete for #{@applicant.name}")
      end
    end

  end
end
