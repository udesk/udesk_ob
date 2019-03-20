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
      header_name = "HTTP_#{UdeskOb::Log::HTTP_HEADER.tr('-', '_')}"
      UdeskOb::Log.trace_id = env[header_name] if env.key?(header_name)
      @app.call(env)
    end
  end
end
