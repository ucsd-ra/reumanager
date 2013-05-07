# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admins
u = User.new(email: 'jgrevich@ucsd.edu', first_name: 'Justin', last_name: 'Grevich', password: 'DemoApp'); u.confirmed_at = DateTime.now; u.save
u = User.new(email: 'mmicou@ucsd.edu', first_name: 'Melissa', last_name: 'Micou', password: 'DemoApp'); u.confirmed_at = DateTime.now; u.save
u = User.new(email: 'vpoola@ucsd.edu', first_name: 'Melissa', last_name: 'Micou', password: 'DemoApp'); u.confirmed_at = DateTime.now; u.save

# Demo Applicants
if ENV['RAILS_ENV'] == 'development' do
  100.times { FactoryGirl.create(:applicant) }; 100.times { FactoryGirl.create(:applicant_with_address) }; 100.times { FactoryGirl.create(:applicant_with_address_and_record) }; 100.times { FactoryGirl.create(:applicant_with_address_record_and_recommender) }; 100.times { FactoryGirl.create(:applicant_with_recommender_and_recommendation) }; 100.times { FactoryGirl.create(:applicant_with_address_record_recommender_and_recommendation) }
end
