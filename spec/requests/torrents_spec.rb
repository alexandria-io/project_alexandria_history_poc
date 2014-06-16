require 'rails_helper'

RSpec.describe "Torrents", :type => :request do
  describe "GET /torrents" do
    it "works! (now write some real specs)" do
      get torrents_path
      expect(response.status).to be(200)
    end
  end
end
