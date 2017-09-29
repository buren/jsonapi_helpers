# frozen_string_literal: true

class MockDeserializer
  def self.jsonapi_parse(jsonapi_hash)
    jsonapi_hash.dig('data', 'attributes')
  end
end
