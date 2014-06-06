require 'rails_helper'

RSpec.describe "Librarians", :type => :request do
  describe "GET /librarians" do
    it "works! (now write some real specs)" do
      get librarians_path
      expect(response.status).to be(200)
    end
  end
end
