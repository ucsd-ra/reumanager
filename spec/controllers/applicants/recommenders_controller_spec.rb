require 'spec_helper'

describe Applicants::RecommendersController do

  context "without authenticated applicant" do

    describe "#edit (GET /applicants/recommenders)" do
      it "redirects to the applicant login" do
        get :edit
        expect(response).to redirect_to new_applicant_session_url
      end

    end

    describe "#update (PUT /applicants/recommenders/1)" do

      it "redirects to the applicant login" do
        put :update, "applicant"=> { "recommenders_attributes" => { "0" => FactoryGirl.attributes_for(:applicant) } }
        expect(response).to redirect_to new_applicant_session_url
      end

    end

  end

  def confirm_and_login(applicant=nil)
    @applicant = applicant || FactoryGirl.create(:applicant)
    @applicant.update_attribute(:confirmed_at, Time.now)
    sign_in @applicant
    @applicant
  end

  context "with authenticated applicant" do
    before { confirm_and_login }

    context "without previous recommenders" do
      describe "#edit (GET /applicants/recommenders)" do

        it "builds a new recommender object with blank attributes for the authenticated applicant" do
          get :edit
          expect(assigns(:applicant).recommenders.first.email).to be_nil
        end

        it "renders the :edit template" do
          get :edit
          expect(response).to render_template :edit
        end

      end

      describe "#update (PUT /applicants/recommenders/1)" do

        context 'with valid recommender attributes' do
          before do
            @recommender_attributes = FactoryGirl.attributes_for(:recommender)
            put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender_attributes } }
          end

          it "redirects to the applicant edit page" do
            expect(response).to redirect_to edit_applicant_registration_url
          end

          it "creates a recommender object for the authenticated applicant using the provided attributes" do
            expect(assigns(:applicant).recommenders.first.email).to eq(@recommender_attributes[:email])
          end
        end

        context 'with INVALID recommender attributes' do
          before do
            @recommender_attributes = FactoryGirl.attributes_for(:recommender, email: nil)
            put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender_attributes } }
          end

          it "re-renders the edit page" do
            expect(response).to render_template(:edit)
          end

          it "does not change the recommender's attributes" do
            expect(assigns(:applicant).recommenders.first.email).to eq(@recommender_attributes[:email])
          end

          it "the recomender object is invalid" do
            expect(assigns(:applicant).recommenders.first).to be_invalid
          end
        end

      end

    end

    context "with existing recommender" do
      before { @recommender = @applicant.recommenders.create(FactoryGirl.attributes_for(:recommender)) }

      describe "#edit (GET /applicants/recommenders)" do

        it "does not build a new recommender object for the authenticated applicant and only loads the existing recommender" do
          get :edit
          expect(assigns(:applicant).recommenders.first).to eq(@recommender)
        end

        it "renders the :edit template" do
          get :edit
          expect(response).to render_template :edit
        end

      end

      describe "#update (PUT /applicants/recommenders/1)" do

        describe "deleting a recommender" do
          before { @applicant_attributes}

          context 'with only one associated applicant/recommendation' do
            it "deletes the recommender association (blank recommendation) when given the proper parameter" do
              put :update, "applicant"=> { "recommenders_attributes" => { "0" => {
                "first_name"=> @recommender.first_name,
                "last_name"=> @recommender.last_name,
                "email"=> @recommender.email,
                "organization"=> @recommender.organization,
                "title"=> @recommender.title,
                "department"=> @recommender.department,
                "id"=> @recommender.id,
                "_destroy"=>"1" } } }

              assigns(:applicant).reload

              expect(assigns(:applicant).recommenders).to eq([])
              expect(Recommender.find_by_email(@recommender.email)).to be_nil
            end
          end

          context 'with more than one associated applicant/recommendation' do
            it "deletes the recommender association (blank recommendation) when given the proper parameter" do
              another_applicant = FactoryGirl.create(:applicant)
              another_applicant.recommenders << @recommender

              put :update, "applicant"=> { "recommenders_attributes" => { "0" => {
                "first_name"=> @recommender.first_name,
                "last_name"=> @recommender.last_name,
                "email"=> @recommender.email,
                "organization"=> @recommender.organization,
                "title"=> @recommender.title,
                "department"=> @recommender.department,
                "id"=> @recommender.id,
                "_destroy"=>"1" } } }

              assigns(:applicant).reload

              expect(assigns(:applicant).recommenders).to eq([])
              expect(Recommender.find_by_email(@recommender.email)).to eq(@recommender)
            end
          end

        end


        context 'with valid recommender attributes' do
          before do
            @recommender_attributes = FactoryGirl.attributes_for(:recommender)
            put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender_attributes } }
          end

          it "redirects to the applicant edit page" do
            expect(response).to redirect_to edit_applicant_registration_url
          end

          it "updates the existing recommender using the provided attributes" do
            expect(assigns(:applicant).recommenders.last.email).to eq(@recommender_attributes[:email])
          end

        end

        context 'with INVALID recommender attributes' do
          before do
            @recommender_attributes = FactoryGirl.attributes_for(:recommender, email: nil)
            put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender_attributes } }
          end

          it "re-renders the edit page" do
            expect(response).to render_template(:edit)
          end

          it "does not change the recommender's attributes" do
            expect(assigns(:applicant).recommenders.last.email).to eq(@recommender_attributes[:email])
          end

        end

      end

    end

    context "with existing recommender in application but not belonging to authenticated applicant" do

      describe "#update (PUT /applicants/recommenders/1)" do
        before do
          @some_other_applicant = FactoryGirl.create(:applicant)
          @recommender = @some_other_applicant.recommenders.create(FactoryGirl.attributes_for(:recommender))
        end

        context 'with valid recommender attributes' do
          before do
            @recommender_attributes = @recommender.attributes
            %w{ created_at updated_at }.map {|key| @recommender_attributes.delete(key) }
            put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender_attributes } }
          end

          it "redirects to the applicant edit page" do
            expect(response).to redirect_to edit_applicant_registration_url
          end

          it "creates a recommender object for the authenticated applicant using the provided attributes" do
            expect(assigns(:applicant).recommenders.first.email).to eq(@recommender.email)
          end
        end # context 'with valid recommender attributes'

        context 'with INVALID recommender attributes' do
          before do
            @recommender_attributes = @recommender.attributes
            @recommender_attributes['title'] = nil
            %w{ created_at updated_at }.map {|key| @recommender_attributes.delete(key) }
            put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender_attributes } }
          end

          it "redirects to the applicant edit page" do
            expect(response).to redirect_to edit_applicant_registration_url
          end

          it "replaces the invalid attribute (and others) with those from the existing recommender" do
            expect(assigns(:applicant).recommenders.first.title).to eq(@recommender.title)
          end

          it "the recomender object is valid due to the reloaded attributes from the existing recommender" do
            expect(assigns(:applicant).recommenders.first).to be_valid
          end
        end # context 'with INVALID recommender attributes'

        describe 'with multiple recommenders (one ex)' do
          context 'with valid recommender attributes' do
            before do
              confirm_and_login(FactoryGirl.create(:applicant_with_recommender))
              @recommender0_attributes = @applicant.recommenders.first.attributes
              @recommender1_attributes = @recommender.attributes
              %w{ created_at updated_at }.map {|key| @recommender0_attributes.delete(key) }
              %w{ created_at updated_at }.map {|key| @recommender1_attributes.delete(key) }
              put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender0_attributes, "1" => @recommender1_attributes } }
            end

            it "redirects to the applicant edit page" do
              expect(response).to redirect_to edit_applicant_registration_url
            end

            it "creates a recommender object for the authenticated applicant using the provided attributes" do
              expect(assigns(:applicant).recommenders.count).to eq(2)

              expect(assigns(:applicant).recommenders.first.email).to eq(@recommender0_attributes['email'])
              expect(assigns(:applicant).recommenders.last.email).to eq(@recommender1_attributes['email'])
            end
          end # context 'with valid recommender attributes'

          context 'with INVALID recommender attributes' do
            before do
              @applicant1 = confirm_and_login(FactoryGirl.create(:applicant_with_recommender))
              @recommender0_attributes = @applicant.recommenders.first.attributes
              @recommender1_attributes = @recommender.attributes
              %w{ created_at updated_at }.map {|key| @recommender0_attributes.delete(key) }
              %w{ id title email created_at updated_at }.map {|key| @recommender1_attributes.delete(key) }
              put :update, "applicant"=> { "recommenders_attributes" => { "0" => @recommender0_attributes, "1" => @recommender1_attributes } }
            end

            it "re-renders the edit page" do
              expect(response).to render_template :edit
            end

            it "does not change the invalid recommender's attributes unless it is able to be looked up by email (email attribute provided)" do
              expect(assigns(:applicant).recommenders.last.organization).to eq(@recommender1_attributes['organization'])
            end

            it "retains the prexisting recommender" do
              expect(assigns(:applicant).recommenders.first.organization).to eq(@recommender0_attributes['organization'])
            end

            it "retains the applicant's recommender count" do
              expect(assigns(:applicant).recommenders.count).to eq(1)
            end

          end # context 'with INVALID recommender attributes'

        end # describe 'with multiple recommenders'
      end # describe "#update (PUT /applicants/recommenders/1)"
    end # context "with existing recommender in application but not belonging to authenticated applicant"
  end # context "with authenticated applicant"
end # describe Applicants::RecommendersController
