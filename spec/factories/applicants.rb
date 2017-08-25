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
    statement { Faker::Lorem.sentences(rand(3) + 7).join(" ") }
    lab_skills { Faker::Lorem.sentences(rand(3) + 2).join(" ") }
    cpu_skills { Faker::Lorem.sentences(rand(3) + 2).join(" ") }

    factory :applicant_with_address do
      after(:create) do |applicant|
        applicant.addresses.create FactoryGirl.attributes_for(:address)
        applicant.set_state
      end
    end

    factory :applicant_with_record do
      after(:create) do |applicant|
        applicant.records.create FactoryGirl.attributes_for(:academic_record)
        applicant.set_state
      end
    end

    factory :applicant_with_address_and_record do
      after(:create) do |applicant|
        applicant.addresses.create FactoryGirl.attributes_for(:address)
        applicant.records.create FactoryGirl.attributes_for(:academic_record)
        applicant.set_state
      end
    end

    factory :applicant_with_recommender do
      after(:create) do |applicant|
        applicant.recommenders.create FactoryGirl.attributes_for(:recommender)
        applicant.set_state
      end
    end

    factory :applicant_with_address_record_and_recommender do
      after(:create) do |applicant|
        applicant.addresses.create FactoryGirl.attributes_for(:address)
        applicant.records.create FactoryGirl.attributes_for(:academic_record)
        applicant.recommenders.create FactoryGirl.attributes_for(:recommender)
        applicant.set_state
      end
    end

    factory :applicant_with_recommender_and_recommendation do
      after(:create) do |applicant|
        applicant.recommenders.create FactoryGirl.attributes_for(:recommender)
      end
      after(:create) do |applicant|
        applicant.recommendation.update_attributes FactoryGirl.attributes_for(:recommendation)
        applicant.set_state
      end
    end

    factory :applicant_with_address_record_recommender_and_recommendation do
      after(:create) do |applicant|
        applicant.addresses.create FactoryGirl.attributes_for(:address)
        applicant.records.create FactoryGirl.attributes_for(:academic_record)
        applicant.recommenders.create FactoryGirl.attributes_for(:recommender)
      end
      after(:create) do |applicant|
        applicant.recommendation.update_attributes FactoryGirl.attributes_for(:recommendation)
        applicant.set_state
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
