require 'rails_helper'

RSpec.describe "grant_settings/index", type: :view do
  before(:each) do
    assign(:grant_settings, [
      GrantSetting.create!(
        :institute => "Institute",
        :department => "Department",
        :department_postal_address => "Department Postal Address",
        :mail_from => "Mail From",
        :funded_by => "Funded By",
        :main_url => "Main Url",
        :department_url => "Department Url",
        :program_url => "Program Url",
        :grant => nil
      ),
      GrantSetting.create!(
        :institute => "Institute",
        :department => "Department",
        :department_postal_address => "Department Postal Address",
        :mail_from => "Mail From",
        :funded_by => "Funded By",
        :main_url => "Main Url",
        :department_url => "Department Url",
        :program_url => "Program Url",
        :grant => nil
      )
    ])
  end

  it "renders a list of grant_settings" do
    render
    assert_select "tr>td", :text => "Institute".to_s, :count => 2
    assert_select "tr>td", :text => "Department".to_s, :count => 2
    assert_select "tr>td", :text => "Department Postal Address".to_s, :count => 2
    assert_select "tr>td", :text => "Mail From".to_s, :count => 2
    assert_select "tr>td", :text => "Funded By".to_s, :count => 2
    assert_select "tr>td", :text => "Main Url".to_s, :count => 2
    assert_select "tr>td", :text => "Department Url".to_s, :count => 2
    assert_select "tr>td", :text => "Program Url".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
