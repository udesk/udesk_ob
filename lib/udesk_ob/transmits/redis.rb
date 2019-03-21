module UdeskOb
  module Transmits
    # MessageQueue encapsulate redis pub/sub.
    class Redis
      CONFIGS = %i[host port db].freeze

      def initialize
        config = UdeskOb::Config.instance
        @client = ::Redis.new(config.options.select { |c| CONFIGS.include?(c) })
        @channel = config.options[:channel]
      end

      def write(content)
        @client.publish(@channel, content)
      end
    end
  end
end
