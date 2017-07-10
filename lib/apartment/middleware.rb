module Apartment
  class Middleware

    def initialize(app, *args)
      @app = app
      @processor = elevator.is_a?(Class) ? elevator.new(*args).method(:parse_tenant_name) : elevator
    end

    def call(env)
      request = Rack::Request.new(env)

      database = @processor.call(request)

      if database
        Apartment::Tenant.switch(database) { @app.call(env) }
      else
        @app.call(env)
      end
    end


    private

    def elevator
      @elevator ||= if Apartment.elevator.is_a?(String)
        require "apartment/elevators/#{Apartment.elevator}"
        "Apartment::Elevators::#{Apartment.elevator.classify}".constantize
      else
        Apartment.elevator
      end
    end

  end
end
