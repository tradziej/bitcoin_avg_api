configure :production, :development do
  uri = URI.parse(settings.redis_url)

  $redis = Redis.new({
    host: uri.host,
    port: uri.port,
    password: uri.password
  })
end
