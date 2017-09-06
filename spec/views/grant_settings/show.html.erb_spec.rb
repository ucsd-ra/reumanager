require 'rails_helper'

RSpec.describe "grant_settings/show", type: :view do
  before(:each) do
    @grant_setting = assign(:grant_setting, GrantSetting.create!(
      :institute => "Institute",
      :department => "Department",
      :department_postal_address => "Department Postal Address",
      :mail_from => "Mail From",
      :funded_by => "Funded By",
      :main_url => "Main Url",
      :department_url => "Department Url",
      :program_url => "Program Url",
      :grant => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Institute/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/Department Postal Address/)
    expect(rendered).to match(/Mail From/)
    expect(rendered).to match(/Funded By/)
    expect(rendered).to match(/Main Url/)
    expect(rendered).to match(/Department Url/)
    expect(rendered).to match(/Program Url/)
    expect(rendered).to match(//)
  end
end
