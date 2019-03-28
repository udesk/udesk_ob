module UdeskOb
  class Transmit
    include Singleton

    def initialize
      config = UdeskOb::Config.instance
      @client = case config.mode
                when :redis
                  UdeskOb::Transmits::Redis.new
                when :logfile
                  UdeskOb::Transmits::Logfile.new
                else
                  raise "Invalid mode: <#{config.mode}>"
                end
    end

    def write(content)
      @client.write(content)
    end
  end
end
