require 'rails_helper'

RSpec.describe "grant_settings/edit", type: :view do
  before(:each) do
    @grant_setting = assign(:grant_setting, GrantSetting.create!(
      :institute => "MyString",
      :department => "MyString",
      :department_postal_address => "MyString",
      :mail_from => "MyString",
      :funded_by => "MyString",
      :main_url => "MyString",
      :department_url => "MyString",
      :program_url => "MyString",
      :grant => nil
    ))
  end

  it "renders the edit grant_setting form" do
    render

    assert_select "form[action=?][method=?]", grant_setting_path(@grant_setting), "post" do

      assert_select "input[name=?]", "grant_setting[institute]"

      assert_select "input[name=?]", "grant_setting[department]"

      assert_select "input[name=?]", "grant_setting[department_postal_address]"

      assert_select "input[name=?]", "grant_setting[mail_from]"

      assert_select "input[name=?]", "grant_setting[funded_by]"

      assert_select "input[name=?]", "grant_setting[main_url]"

      assert_select "input[name=?]", "grant_setting[department_url]"

      assert_select "input[name=?]", "grant_setting[program_url]"

      assert_select "input[name=?]", "grant_setting[grant_id]"
    end
  end
end
