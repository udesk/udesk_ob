module UdeskOb
  # MessageQueue encapsulate redis pub/sub.
  class MessageQueue
    include Singleton

    def initialize
      config = UdeskOb::Config.instance
      @redis = Redis.new(host: config.mq_host, port: config.mq_port, db: 0)
    end

    def publish(content)
      config = UdeskOb::Config.instance
      @redis.publish(config.mq_channel, content)
    end
  end
end
