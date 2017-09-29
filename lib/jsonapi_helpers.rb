# frozen_string_literal: true

require 'active_support/core_ext/object/json'

# Local requires
require 'jsonapi_helpers/version'

require 'jsonapi_helpers/support/key_transform'
require 'jsonapi_helpers/support/string_support'

require 'jsonapi_helpers/serializers/deserializer'
require 'jsonapi_helpers/serializers/model'
require 'jsonapi_helpers/serializers/model_error'
require 'jsonapi_helpers/serializers/data'
require 'jsonapi_helpers/serializers/datum'
require 'jsonapi_helpers/serializers/error'
require 'jsonapi_helpers/serializers/errors'

require 'jsonapi_helpers/params/fields'
require 'jsonapi_helpers/params/filter'
require 'jsonapi_helpers/params/includes'
require 'jsonapi_helpers/params/sort'

module JSONAPIHelpers
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    block_given? ? yield(config) : config
    config
  end

  class Configuration
    KEY_TRANSFORMS = %i(dash camel camel_lower underscore unaltered).freeze

    attr_reader :key_transform
    attr_writer :deserializer_klass, :params_klass

    def initialize
      @key_transform = :unaltered
      @deserializer_klass = nil
      @params_klass = nil
    end

    def key_transform=(key_transform)
      type = key_transform.to_sym
      unknown_key_transform!(type) unless KEY_TRANSFORMS.include?(type)

      @key_transform = type
    end

    def deserializer_klass
      @deserializer_klass || fail('deserializer_klass must be set, e.g: ActiveModelSerializers::Deserialization') # rubocop:disable Metrics/LineLength
    end

    def params_klass
      @params_klass || fail('params_klass must be set, e.g: ActionController::Parameters')
    end

    private

    def unknown_key_transform!(type)
      types = KEY_TRANSFORMS.join(', ')
      fail(ArgumentError, "Unknown key transform type '#{type}', known types: #{types}")
    end
  end
end
