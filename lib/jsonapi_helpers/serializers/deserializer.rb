# frozen_string_literal: true

module JSONAPIHelpers
  module Serializers
    module Deserializer
      def self.parse(params)
        # Parse the params hash and "flatten" the structure
        parsed_params = JSONAPIHelpers.config.deserializer_klass.jsonapi_parse(params)
        # Pass the hash to a params klass where normal whitelisting of params can be made
        JSONAPIHelpers.config.params_klass.new(parsed_params || {})
      end
    end
  end
end
