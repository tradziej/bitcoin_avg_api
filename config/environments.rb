configure :production, :development do
  $redis = Redis.new({
    host: settings.redis[:host],
    port: settings.redis[:port]
  })
end
