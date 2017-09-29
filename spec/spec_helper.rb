# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jsonapi_helpers'

require 'spec_support/mock_deserializer'
require 'spec_support/mock_params'

JSONAPIHelpers.configure do |config|
  config.deserializer_klass = MockDeserializer
  config.params_klass = MockParams
end
