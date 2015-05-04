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

  describe "/api" do
    describe "/price/:currency" do
      let(:path){ "api/price/" }

      context "when currency is incorrect" do
        let(:currency){ "FAKE" }
        let(:endpoint){ path.concat(currency) }

        it "returns 404 status code" do
          get endpoint
          expect(last_response.status).to eq(404)
        end

        it "returns not found response body" do
          get endpoint
          expect(last_response.body).to be_json_eql(%({"error":"not-found"}))
        end
      end

      context "when currency is correct" do
        let(:currency){ "USD" }
        let(:endpoint){ path.concat(currency) }

        before{ allow(BitcoinAverage).to receive_message_chain(:global, :last).and_return(100.55) }

        it "returns 200 status code" do
          get endpoint
          expect(last_response.status).to eq(200)
        end

        it "returns JSON body" do
          get endpoint
          expect(last_response.body).to be_json_eql(%({"price": 100.55, "currency":"USD"}))
        end
      end
    end
  end
end
