# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :academic_record do
    university {  %w{ UC\ San Diego UCLA UCSF UC\ Irvine UC\ Riverside Harvard Stanford }[rand(7)] }
    degree { %w{ Bioengineering Biology Chemistry Bioinformatics Biotechnology Medicine} }
    start { Date.civil(2008,9,20) }
    finish { Date.civil(2013,1,20) }
    gpa { rand(0.5..4.0) }
    gpa_range { 4.0 }
    academic_level { %w{ Freshman Sophomore Junior Senior }[rand(4)] }
    gpa_comment { Faker::Lorem.sentences(3).join(' ') }
  end
end