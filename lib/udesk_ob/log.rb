module UdeskOb
  # save log and maintain trace_id
  module Log
    HTTP_HEADER = 'X-UDESK-OB-TRACE-ID'.freeze
    SIDEKIQ_META = 'UDESK_OB_TRACE_ID'.freeze
    THREAD_VAR = 'UDESK_OB_TRACE_ID'.freeze

    def self.save(task_id, node_id, content)
      message = default_headers
      message[:task_id] = task_id
      message[:node_id] = node_id
      message[:content] = content

      transmit = UdeskOb::Transmit.instance
      transmit.write(message.to_json)
    end

    def self.default_headers
      config = UdeskOb::Config.instance

      {
        trace_id:   trace_id,
        timestamp:  Time.now.to_s,
        host_name:  config.host_name,
        host_ip:    config.host_ip
      }
    end

    def self.trace_id
      id = Thread.current[THREAD_VAR]
      if id.nil?
        id = SecureRandom.uuid
        Thread.current[THREAD_VAR] = id
      end
      id
    end

    def self.trace_id=(id)
      Thread.current[THREAD_VAR] = id
    end
  end
end
