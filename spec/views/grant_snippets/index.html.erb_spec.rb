require 'rails_helper'

RSpec.describe "grant_snippets/index", type: :view do
  before(:each) do
    assign(:grant_snippets, [
      GrantSnippet.create!(
        :general_desc => "MyText",
        :highlights => "MyText",
        :eligibility => "MyText",
        :grant => nil
      ),
      GrantSnippet.create!(
        :general_desc => "MyText",
        :highlights => "MyText",
        :eligibility => "MyText",
        :grant => nil
      )
    ])
  end

  it "renders a list of grant_snippets" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
