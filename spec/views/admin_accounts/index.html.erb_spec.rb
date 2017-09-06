require 'rails_helper'

RSpec.describe "admin_accounts/index", type: :view do
  before(:each) do
    assign(:admin_accounts, [
      AdminAccount.create!(
        :admin1_email => "Admin1 Email",
        :admin1_pwd => "Admin1 Pwd",
        :admin2_email => "Admin2 Email",
        :admin2_pwd => "Admin2 Pwd",
        :admin3_email => "Admin3 Email",
        :admin3_pwd => "Admin3 Pwd",
        :admin4_email => "Admin4 Email",
        :admin4_pwd => "Admin4 Pwd",
        :admin5_email => "Admin5 Email",
        :admin5_pwd => "Admin5 Pwd",
        :grant => nil
      ),
      AdminAccount.create!(
        :admin1_email => "Admin1 Email",
        :admin1_pwd => "Admin1 Pwd",
        :admin2_email => "Admin2 Email",
        :admin2_pwd => "Admin2 Pwd",
        :admin3_email => "Admin3 Email",
        :admin3_pwd => "Admin3 Pwd",
        :admin4_email => "Admin4 Email",
        :admin4_pwd => "Admin4 Pwd",
        :admin5_email => "Admin5 Email",
        :admin5_pwd => "Admin5 Pwd",
        :grant => nil
      )
    ])
  end

  it "renders a list of admin_accounts" do
    render
    assert_select "tr>td", :text => "Admin1 Email".to_s, :count => 2
    assert_select "tr>td", :text => "Admin1 Pwd".to_s, :count => 2
    assert_select "tr>td", :text => "Admin2 Email".to_s, :count => 2
    assert_select "tr>td", :text => "Admin2 Pwd".to_s, :count => 2
    assert_select "tr>td", :text => "Admin3 Email".to_s, :count => 2
    assert_select "tr>td", :text => "Admin3 Pwd".to_s, :count => 2
    assert_select "tr>td", :text => "Admin4 Email".to_s, :count => 2
    assert_select "tr>td", :text => "Admin4 Pwd".to_s, :count => 2
    assert_select "tr>td", :text => "Admin5 Email".to_s, :count => 2
    assert_select "tr>td", :text => "Admin5 Pwd".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
