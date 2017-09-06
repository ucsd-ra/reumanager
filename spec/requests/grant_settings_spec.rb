require 'rails_helper'

RSpec.describe "GrantSettings", type: :request do
  describe "GET /grant_settings" do
    it "works! (now write some real specs)" do
      get grant_settings_path
      expect(response).to have_http_status(200)
    end
  end
end
