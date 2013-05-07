# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :snippet do
    title "MyString"
    description "MyText"
    value "MyText"
  end
end
