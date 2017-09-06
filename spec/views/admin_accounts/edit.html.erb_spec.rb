require 'rails_helper'

RSpec.describe "admin_accounts/edit", type: :view do
  before(:each) do
    @admin_account = assign(:admin_account, AdminAccount.create!(
      :admin1_email => "MyString",
      :admin1_pwd => "MyString",
      :admin2_email => "MyString",
      :admin2_pwd => "MyString",
      :admin3_email => "MyString",
      :admin3_pwd => "MyString",
      :admin4_email => "MyString",
      :admin4_pwd => "MyString",
      :admin5_email => "MyString",
      :admin5_pwd => "MyString",
      :grant => nil
    ))
  end

  it "renders the edit admin_account form" do
    render

    assert_select "form[action=?][method=?]", admin_account_path(@admin_account), "post" do

      assert_select "input[name=?]", "admin_account[admin1_email]"

      assert_select "input[name=?]", "admin_account[admin1_pwd]"

      assert_select "input[name=?]", "admin_account[admin2_email]"

      assert_select "input[name=?]", "admin_account[admin2_pwd]"

      assert_select "input[name=?]", "admin_account[admin3_email]"

      assert_select "input[name=?]", "admin_account[admin3_pwd]"

      assert_select "input[name=?]", "admin_account[admin4_email]"

      assert_select "input[name=?]", "admin_account[admin4_pwd]"

      assert_select "input[name=?]", "admin_account[admin5_email]"

      assert_select "input[name=?]", "admin_account[admin5_pwd]"

      assert_select "input[name=?]", "admin_account[grant_id]"
    end
  end
end
