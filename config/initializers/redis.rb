module Rails
  class << self
    def redis
      redis_connection.client.connect unless redis_connection.client.connected?
      @_redis ||= Redis::Namespace.new("anifier-#{Rails.env}", redis: redis_connection)
    end

    def redis_connection
      @_redis_connection ||= begin
        conf = YAML.load_file('config/redis.yml')
        raise "Redis not configured for #{Rails.env}" unless conf.key?(Rails.env)

        conf = conf[Rails.env]
        conn = Redis.new(host: conf['host'], port: conf['port'].to_i)
        conn.auth(conf['password']) if conf['password'].present?
        conn.select(conf['database'].to_i) if conf['database'].present?
        conn
      end
    end

  end
end