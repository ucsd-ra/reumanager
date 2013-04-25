# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  # confirmed applicant
  factory :applicant do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password { Faker::Lorem.words(6).join('-') }
    academic_level { %w{ Freshman Sophomore Junior Senior }[rand(4)] }

    factory :applicant_with_recommender do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      email { Faker::Internet.email }
      phone { Faker::PhoneNumber.phone_number }
      password { Faker::Lorem.words(6).join('-') }
      academic_level { %w{ Freshman Sophomore Junior Senior }[rand(4)] }

      after(:create) do |applicant|
        applicant.recommenders.create FactoryGirl.attributes_for(:recommender)
      end
    end
    
    factory :unconfirmed_applicant do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      email { Faker::Internet.email }
      phone { Faker::PhoneNumber.phone_number }
      password { Faker::Lorem.words(6).join('-') }
      academic_level { %w{ Freshman Sophomore Junior Senior }[rand(4)] }
    end
    
  end

end
