require 'rails_helper'

RSpec.describe "GrantSnippets", type: :request do
  describe "GET /grant_snippets" do
    it "works! (now write some real specs)" do
      get grant_snippets_path
      expect(response).to have_http_status(200)
    end
  end
end
