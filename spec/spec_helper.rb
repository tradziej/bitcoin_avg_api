require 'rack/test'
require 'rspec'
require 'json_spec'

require File.expand_path '../../app.rb', __FILE__

ENV['RACK_ENV'] = 'test'
ENV['API_USER'] = 'user'
ENV['API_PASSWORD'] = 'pass'

module RSpecMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.color = true
  config.formatter = :documentation
end
