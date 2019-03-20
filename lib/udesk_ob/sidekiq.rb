module UdeskOb
  module SidekiqMiddleware
    class Client
      def call(_worker_class, job, _queue, _redis_pool)
        job[UdeskOb::Log::SIDEKIQ_META] = UdeskOb::Log.trace_id
        yield
      end
    end

    class Server
      def call(_worker, job, _queue)
        if job[UdeskOb::Log::SIDEKIQ_META]
          UdeskOb::Log.trace_id = job[UdeskOb::Log::SIDEKIQ_META]
        end
        yield
      end
    end
  end
end

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add UdeskOb::SidekiqMiddleware::Client
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add UdeskOb::SidekiqMiddleware::Server
  end
end
