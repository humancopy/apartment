require 'rack/request'
require 'apartment/tenant'

module Apartment
  module Elevators
    #   Provides a rack based tenant switching solution based on request
    #
    class Generic
      def parse_tenant_name(request)
        raise "Override"
      end
    end
  end
end
