require 'spec_helper'

describe Award do
  it "should have a date, description, and is valid with a title" do
    award = Award.new(date: '4/24/1988', description: 'Some text goes in here', title: 'title of award')
    expect(award).to be_valid
  end
  
  it "is invalid without a title" do
    expect(Award.new(title: nil)).to have(1).error_on(:title)
  end
  
  
end
