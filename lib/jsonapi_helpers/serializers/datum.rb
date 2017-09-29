# frozen_string_literal: true

module JSONAPIHelpers
  module Serializers
    class Datum
      def initialize(jsonapi_datums)
        @datums = jsonapi_datums
      end

      def to_h
        {
          data: @datums.map { |data| data.to_h(shallow: true) },
          meta: {
            total: @datums.length
          }
        }
      end

      # Rails is awkward and calls #to_json with a context argument
      # NOTE: Rails only method Hash#to_json
      def to_json(_context = nil)
        to_h.to_json
      end
    end
  end
end
