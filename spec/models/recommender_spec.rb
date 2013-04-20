require 'spec_helper'

describe Recommender do

  # object instantiation
  it { should be_an_instance_of(Recommender) }

  # association(s)
  it { should respond_to :applicants }
  it { should have_many :applicants }
  it { should respond_to :recommendations }
  it { should have_many :recommendations }
  
  %w{ first_name last_name email organization department title}.each do |m|
    it "is NOT valid without the required attribute '#{m}'"  do
      recommender = Recommender.create(FactoryGirl.attributes_for(:recommender, m.to_sym => nil))
      expect(recommender).to be_invalid
    end
  end
  
  it 'returns the combination of firstname / lastname when called with .name' do
    recommender = FactoryGirl.create(:recommender)
    expect(recommender.name).to eq("#{recommender.first_name} #{recommender.last_name}")
  end

  it 'requires the email to be unique' do
    recommender = FactoryGirl.create(:recommender)
    
    same_email_recommender = FactoryGirl.build(:recommender, email: recommender.email)
    expect(same_email_recommender).to be_invalid
  end
end
