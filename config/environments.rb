require 'yaml'

configure :production, :development do
  REDIS_CONFIG = YAML.load(File.open("config/redis.yml")).symbolize_keys

  $redis = Redis.new(REDIS_CONFIG[settings.environment])
end
