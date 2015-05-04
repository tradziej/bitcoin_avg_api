require 'bitcoinaverage'

module Services
  class BitcoinPrice
    CACHE_TTL = 60

    def initialize(currency)
      @currency = currency
    end

    def get
      read_from_cache or fetch
    end

    def fetch
      price = BitcoinAverage.global(@currency).last

      store_in_cache price

      price
    end

   private
    def read_from_cache
      return nil if $redis.nil?

      cached = $redis.get("bitcoin-#{@currency}-price")

      cached ? cached.to_f : nil
    end

    def store_in_cache price
      unless $redis.nil?
        $redis.setex("bitcoin-#{@currency}-price", CACHE_TTL, price)
      end
    end
  end
end
