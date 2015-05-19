### Bitcoin prices JSON API

This is a Sinatra app that expose a REST API for bitcoin prices (https://bitcoinaverage.com/).

You need to have Redis installed if you want to enable cache. Results are kept in cache for 60 seconds by default.

Sample configuration is in `.env.example` file.
Please create your own `.env` file.

By default endpoints are secured by Basic access authentication.

Example request:

	GET :host/api/price/usd

Example response:

	{
		"price": 234.23,
		"currency": "USD"
	}

App supports almost every currency in the [ISO 4217](http://en.wikipedia.org/wiki/ISO_4217) standard.

## Requirements
* Redis

## Installation
	$ bundle install

## Running
	$ ruby app.rb

## Requsting API

	/api/price/:currency

## Contributing

1. Fork it ( https://github.com/tradziej/bitcoin_avg_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
