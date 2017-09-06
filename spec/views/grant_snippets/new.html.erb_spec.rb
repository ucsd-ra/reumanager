require 'rails_helper'

RSpec.describe "grant_snippets/new", type: :view do
  before(:each) do
    assign(:grant_snippet, GrantSnippet.new(
      :general_desc => "MyText",
      :highlights => "MyText",
      :eligibility => "MyText",
      :grant => nil
    ))
  end

  it "renders new grant_snippet form" do
    render

    assert_select "form[action=?][method=?]", grant_snippets_path, "post" do

      assert_select "textarea[name=?]", "grant_snippet[general_desc]"

      assert_select "textarea[name=?]", "grant_snippet[highlights]"

      assert_select "textarea[name=?]", "grant_snippet[eligibility]"

      assert_select "input[name=?]", "grant_snippet[grant_id]"
    end
  end
end
