module UdeskOb
  class Transmit
    include Singleton

    def initialize
      config = UdeskOb::Config.instance
      @client = case config.mode
                when :redis
                  UdeskOb::Transmits::Redis.new
                end
    end

    def write(content)
      @client.write(content)
    end
  end
end
