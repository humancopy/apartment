require 'apartment/elevators/generic'

module Apartment
  module Elevators
    #   Provides a rack based tenant switching solution based on hosts
    #   Uses a hash to find the corresponding tenant name for the host
    #
    class HostHash < Generic
      def initialize(hash = {})
        @hash = hash
      end

      def parse_tenant_name(request)
        raise TenantNotFound,
          "Cannot find tenant for host #{request.host}" unless @hash.has_key?(request.host)

        @hash[request.host]
      end
    end
  end
end
