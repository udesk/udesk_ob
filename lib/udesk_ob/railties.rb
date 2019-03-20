module UdeskOb
  class Railtie < Rails::Railtie
    initializer 'udesk_ob.insert_middleware' do |app|
      app.middleware.use UdeskOb::RailsMiddleware
    end
  end

  class RailsMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if env.has_key?(UdeskOb::Log::HTTP_HEADER)
        UdeskOb::Log.trace_id = env[UdeskOb::Log::HTTP_HEADER]
      end
      @app.call(env)
    end
  end
end
