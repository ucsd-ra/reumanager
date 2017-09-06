# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommendation do
    body { Faker::Lorem.sentences(rand(5)+4).join(' ') }
    known_applicant_for { ['1 year', '1-2 years', '2-3 years', '3-4 years', '>4 years'][rand(5)] }
    known_capacity { ['Undergrad in one course', 'Undergrad in multiple courses', 'Research Assistant', 'Teaching Assistant'][rand(4)] }
    overall_promise { ['Top 1%', 'Top 5%', 'Top 10%', 'Top 25%', 'average', 'below average'][rand(6)] }
    undergraduate_institution { ['Yes', 'No', nil][rand(3)] }

    factory :recommendation_with_associations do
      applicant_id { FactoryGirl.create(:applicant).id }
      recommender_id { FactoryGirl.create(:recommender).id }
    end
  end
end
