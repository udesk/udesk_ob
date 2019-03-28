module UdeskOb
  # config
  class Config
    include Singleton
    MODES = %i[redis logfile].freeze

    # mode: :redis
    # redis options: [:host, :port, :db, :channel]
    # logfile options: [:path]
    attr_accessor :mode, :options, :host_name, :host_ip

    def initialize
      @host_name = Socket.gethostname
      ip = Socket.ip_address_list.detect(&:ipv4_private?)
      @host_ip = ip.nil? ? 'unknow' : ip.ip_address
    end
  end

  def self.configure
    config = UdeskOb::Config.instance
    yield config
    return if UdeskOb::Config::MODES.include?(config.mode)
    raise "Mode must be #{UdeskOb::Config::MODES.inspect}, <#{config.mode.inspect}> is invalid"
  end
end
