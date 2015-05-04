require 'bitcoinaverage'

module Services
  class BitcoinPrice
    def get currency
      BitcoinAverage.global(currency).last
    end
  end
end
