require File.expand_path '../../spec_helper.rb', __FILE__

describe Services::BitcoinPrice do
  let(:price){ 100.55 }

  before do
    allow(BitcoinAverage).to receive_message_chain(:global, :last).and_return(price)

    redis_double = double()
    allow(redis_double).to receive(:setex)
    $redis = redis_double
  end

  describe "#get" do
    subject { described_class.new('USD').get }

    context "when price is not cached" do
      before do
        allow($redis).to receive(:get).and_return(nil)
      end

      it "calls #fetch and returns price" do
        expect_any_instance_of(Services::BitcoinPrice).to receive(:fetch).and_call_original
        expect(subject).to eq(price)
      end
    end

    context "when price is cached" do
      before do
        allow($redis).to receive(:get).and_return(price)
      end

      it "does not call #fetch but returns price" do
        expect_any_instance_of(Services::BitcoinPrice).to_not receive(:fetch)
        expect(subject).to eq(price)
      end
    end
  end

  describe "#fetch" do
    subject { described_class.new('USD').fetch }

    it "returns price" do
      expect(subject).to eq(price)
    end

    it "updates cache" do
      expect($redis).to receive(:setex)
      subject
    end
  end
end
