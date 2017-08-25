require 'spec_helper'

describe "grants/edit" do
  before(:each) do
    @grant = assign(:grant, stub_model(Grant,
      :program_title => "MyString",
      :institution => "MyString",
      :department => "MyString",
      :program_description => "MyString",
      :subdomain => "MyString"
    ))
  end

  it "renders the edit grant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", grant_path(@grant), "post" do
      assert_select "input#grant_program_title[name=?]", "grant[program_title]"
      assert_select "input#grant_institution[name=?]", "grant[institution]"
      assert_select "input#grant_department[name=?]", "grant[department]"
      assert_select "input#grant_program_description[name=?]", "grant[program_description]"
      assert_select "input#grant_subdomain[name=?]", "grant[subdomain]"
    end
  end
end
