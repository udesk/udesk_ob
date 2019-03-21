module UdeskOb
  # config
  class Config
    include Singleton
    attr_accessor :mq_host, :mq_port, :mq_channel
  end

  def self.configure
    yield UdeskOb::Config.instance
  end
end
