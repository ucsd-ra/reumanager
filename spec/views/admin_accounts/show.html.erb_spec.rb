require 'rails_helper'

RSpec.describe "admin_accounts/show", type: :view do
  before(:each) do
    @admin_account = assign(:admin_account, AdminAccount.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Admin1 Email/)
    expect(rendered).to match(/Admin1 Pwd/)
    expect(rendered).to match(/Admin2 Email/)
    expect(rendered).to match(/Admin2 Pwd/)
    expect(rendered).to match(/Admin3 Email/)
    expect(rendered).to match(/Admin3 Pwd/)
    expect(rendered).to match(/Admin4 Email/)
    expect(rendered).to match(/Admin4 Pwd/)
    expect(rendered).to match(/Admin5 Email/)
    expect(rendered).to match(/Admin5 Pwd/)
    expect(rendered).to match(//)
  end
end
