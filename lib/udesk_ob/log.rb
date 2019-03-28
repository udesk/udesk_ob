module UdeskOb
  # save log and maintain trace_id
  module Log
    HTTP_HEADER = 'X-UDESK-OB-TRACE-ID'.freeze
    SIDEKIQ_META = 'UDESK_OB_TRACE_ID'.freeze
    THREAD_VAR_TRACE_ID = 'UDESK_OB_TRACE_ID'.freeze
    THREAD_VAR_PROCESS_ID = 'UDESK_OB_PROCESS_ID'.freeze
    THREAD_VAR_PROCESS_TYPE = 'UDESK_OB_PROCESS_TYPE'.freeze

    def self.info(task_id, node_id, content)
      save(task_id, node_id, content, 'info')
    end

    def self.warn(task_id, node_id, content)
      save(task_id, node_id, content, 'warn')
    end

    def self.error(task_id, node_id, content)
      save(task_id, node_id, content, 'error')
    end

    def self.fatal(task_id, node_id, content)
      save(task_id, node_id, content, 'fatal')
    end

    def self.save(task_id, node_id, content, level = 'info')
      message = default_headers
      message[:level]   = level
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
        process_id: process_id,
        process_type: process_type,
        timestamp:  Time.now.to_s,
        host_name:  config.host_name,
        host_ip:    config.host_ip,
        project:    config.project
      }
    end

    def self.process_id
      Thread.current[THREAD_VAR_PROCESS_ID]
    end

    def self.process_id=(id)
      Thread.current[THREAD_VAR_PROCESS_ID] = id
    end

    def self.process_type
      Thread.current[THREAD_VAR_PROCESS_TYPE]
    end

    def self.process_type=(type)
      Thread.current[THREAD_VAR_PROCESS_TYPE] = type
    end

    def self.trace_id
      id = Thread.current[THREAD_VAR_TRACE_ID]
      if id.nil?
        id = SecureRandom.uuid
        Thread.current[THREAD_VAR_TRACE_ID] = id
      end
      id
    end

    def self.trace_id=(id)
      Thread.current[THREAD_VAR_TRACE_ID] = id
    end
  end
end
