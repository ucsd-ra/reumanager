require 'spec_helper'

describe "grants/index" do
  before(:each) do
    assign(:grants, [
      stub_model(Grant,
        :program_title => "Program Title",
        :institution => "Institution",
        :department => "Department",
        :program_description => "Program Description",
        :subdomain => "Subdomain"
      ),
      stub_model(Grant,
        :program_title => "Program Title",
        :institution => "Institution",
        :department => "Department",
        :program_description => "Program Description",
        :subdomain => "Subdomain"
      )
    ])
  end

  it "renders a list of grants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Program Title".to_s, :count => 2
    assert_select "tr>td", :text => "Institution".to_s, :count => 2
    assert_select "tr>td", :text => "Department".to_s, :count => 2
    assert_select "tr>td", :text => "Program Description".to_s, :count => 2
    assert_select "tr>td", :text => "Subdomain".to_s, :count => 2
  end
end
