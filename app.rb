require 'sinatra'
require 'sinatra/namespace'
require 'redis'
require './services/bitcoin_price'

require 'dotenv'
Dotenv.load

require './config/environments'

use Rack::Auth::Basic, "API authentication" do |username, password|
  username == ENV['API_USER'] && password == ENV['API_PASSWORD']
end

def currencies
  %w(
    AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD BIF BMD BND
    BOB BRL BSD BTC BTN BWP BYR BZD CAD CDF CHF CLF CLP CNY COP CRC CUC CUP
    CVE CZK DJF DKK DOP DZD EEK EGP ERN ETB EUR FJD FKP GBP GEL GGP GHS GIP
    GMD GNF GTQ GYD HKD HNL HRK HTG HUF IDR ILS IMP INR IQD IRR ISK JEP JMD
    JOD JPY KES KGS KHR KMF KPW KRW KWD KYD KZT LAK LBP LKR LRD LSL LTL LVL
    LYD MAD MDL MGA MKD MMK MNT MOP MRO MTL MUR MVR MWK MXN MYR MZN NAD NGN
    NIO NOK NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF SAR
    SBD SCR SDG SEK SGD SHP SLL SOS SRD STD SVC SYP SZL THB TJS TMT TND TOP
    TRY TTD TWD TZS UAH UGX USD UYU UZS VEF VND VUV WST XAF XAG XAU XCD XDR
    XOF XPF YER ZAR ZMK ZMW ZWL
  )
end

get '/' do
end

namespace '/api' do
  before { content_type :json }

  namespace '/price' do
    get '/:currency' do
      currency = params[:currency].upcase

      if currencies.include?(currency)
        {
          price: Services::BitcoinPrice.new(currency).get,
          currency: currency
        }.to_json
      else
        status(404)
      end
    end
  end
end

not_found do
  content_type :json
  halt 404, {error: "not-found"}.to_json
end
