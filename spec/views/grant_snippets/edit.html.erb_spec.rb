require 'rails_helper'

RSpec.describe "grant_snippets/edit", type: :view do
  before(:each) do
    @grant_snippet = assign(:grant_snippet, GrantSnippet.create!(
      :general_desc => "MyText",
      :highlights => "MyText",
      :eligibility => "MyText",
      :grant => nil
    ))
  end

  it "renders the edit grant_snippet form" do
    render

    assert_select "form[action=?][method=?]", grant_snippet_path(@grant_snippet), "post" do

      assert_select "textarea[name=?]", "grant_snippet[general_desc]"

      assert_select "textarea[name=?]", "grant_snippet[highlights]"

      assert_select "textarea[name=?]", "grant_snippet[eligibility]"

      assert_select "input[name=?]", "grant_snippet[grant_id]"
    end
  end
end
