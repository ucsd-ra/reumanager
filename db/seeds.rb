# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admins
admins = [{ email: 'brey@iit.edu', first_name: 'Eric', last_name: 'Brey', password: 'REUappIIT'},
          { email: 'damico@iit.edu', first_name: 'Cathie', last_name: "D'amico", password: 'REUappIIT' },
          { email: 'weaver@iit.edu', first_name: 'Renee', last_name: 'Weaver', password: 'REUappIIT' },
          { email: 'rob@notch8.com', first_name: 'Rob', last_name: 'Kaufman', password: 'REUappIIT' }]

admins.map { |user| admin = User.new(user); admin.confirmed_at = DateTime.now; admin.save; }

# Demo Applicants
if ENV['RAILS_ENV'] == 'development'
  100.times do
    FactoryGirl.create(:applicant)
    FactoryGirl.create(:applicant_with_address)
    FactoryGirl.create(:applicant_with_address_and_record)
    FactoryGirl.create(:applicant_with_address_record_and_recommender)
    FactoryGirl.create(:applicant_with_recommender_and_recommendation)
    FactoryGirl.create(:applicant_with_address_record_recommender_and_recommendation)
  end
end
