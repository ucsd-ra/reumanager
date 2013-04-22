# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommender do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    organization { Faker::Company.name }
    department { %w{ Bioengineering Engineering Biology Nanotechnology Chemistry Medicine }[rand 6] }
    title { %w{ Professor Assistant\ Professor Research\ Scientist Dean }[rand 4] }
  end
end
