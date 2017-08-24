require 'spec_helper'

describe "grants/show" do
  before(:each) do
    @grant = assign(:grant, stub_model(Grant,
      :program_title => "Program Title",
      :institution => "Institution",
      :department => "Department",
      :program_description => "Program Description",
      :subdomain => "Subdomain"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Program Title/)
    rendered.should match(/Institution/)
    rendered.should match(/Department/)
    rendered.should match(/Program Description/)
    rendered.should match(/Subdomain/)
  end
end
