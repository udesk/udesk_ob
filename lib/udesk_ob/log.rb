module UdeskOb
  module Log
    HTTP_HEADER = 'X-UDESK-OB-TRACE-ID'.freeze
    SIDEKIQ_META = 'UDESK_OB_TRACE_ID'.freeze
    THREAD_VAR = 'UDESK_OB_TRACE_ID'.freeze

    def self.save(content)
      message = {
        trace_id: trace_id,
        content: content
      }
      mq = UdeskOb::MessageQueue.instance
      mq.publish(message.to_json)
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
