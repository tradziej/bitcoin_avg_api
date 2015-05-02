require File.expand_path '../spec_helper.rb', __FILE__

describe "Bitcoin average price app" do
  describe '/' do
    let(:endpoint) { '/' }
    it "returns a 200 status code" do
      get endpoint
      expect(last_response.status).to eq(200)
    end
    it "returns empty body" do
      get endpoint
      expect(last_response.body).to be_empty
    end
  end
end
