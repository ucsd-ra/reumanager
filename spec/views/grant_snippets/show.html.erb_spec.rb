require 'rails_helper'

RSpec.describe "grant_snippets/show", type: :view do
  before(:each) do
    @grant_snippet = assign(:grant_snippet, GrantSnippet.create!(
      :general_desc => "MyText",
      :highlights => "MyText",
      :eligibility => "MyText",
      :grant => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
