# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :award do
    title {  %w{ UC\ San Diego UCLA UCSF UC\ Irvine UC\ Riverside Harvard Stanford }[rand(7)] + " Dean's List" }
    date { Date.civil(2009,2,4) }
    description { Faker::Lorem.sentences(2).join(' ') }
  end
end