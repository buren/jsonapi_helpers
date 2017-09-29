# JSONAPIHelpers
[![Build Status](https://travis-ci.org/buren/jsonapi_helpers.svg?branch=master)](https://travis-ci.org/buren/jsonapi_helpers)

A set of helpers for generating JSON API compliant responses with together with the active_model_serializers gem.

:warning: The API for this is still pretty rough.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jsonapi_helpers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jsonapi_helpers

## Usage

:warning: You must configure `deserializer_klass` and `params_klass`, if you want to use the `Dersializer`.

```ruby
require 'jsonapi_helpers'

include JSONAPIHelpers::Alias

JSONAPIHelpers.configure do |config|
  config.deserializer_klass = ActiveModelSerializers::Deserialization
  config.params_klass = ActionController::Parameters
  # optional (unaltered is the default)
  config.key_transform = :dash # camel, camel_lower, underscore, unaltered
end

# Error
errors = JSONAPIHelpers::Serializers::Errors.new
errors.add(status: 422, detail: 'too short', attribute: :first_name).to_h
errors.to_h
# => {
#   errors: [{
#     :status => 422,
#     :detail => 'too short',
#     :source => {
#       :pointer => "/data/attributes/first-name"
#     }
#   }]
# }

# In ApplicationController you can define
class ApplicationController < ActionController::Base
  # Define these constants in your controllers that you'd like to have
  # different/custom behavior
  DEFAULT_SORTING = { created_at: :desc }.freeze
  SORTABLE_FIELDS = [].freeze

  ALLOWED_INCLUDES = [].freeze

  TRANSFORMABLE_FILTERS = { created_at: :date_range }.freeze
  ALLOWED_FILTERS = %i(created_at).freeze

  def jsonapi_params
    @_deserialized_params ||= JSONAPIHelpers::Serializers::Deserializer.parse(params)
  end

  def include_params
    @_include_params ||= JSONAPIHelpers::Params::Includes.new(params[:include])
  end

  def fields_params
    @_fields_params ||= JSONAPIHelpers::Params::Fields.new(params[:fields])
  end

  def sort_params
    sortable_fields = self.class::SORTABLE_FIELDS
    default_sorting = self.class::DEFAULT_SORTING
    @_sort_params = JSONAPIHelpers::Params::Sort.build(params[:sort], sortable_fields, default_sorting)
  end

  def filter_params
    filterable_fields = self.class::ALLOWED_FILTERS
    transformable = self.class::TRANSFORMABLE_FILTERS
    @_filter_params = JSONAPIHelpers::Params::Filter.build(params[:filter], filterable_fields, transformable)
  end

  # ...
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Future

* Testing the `Serializer` class is currently not "possible" and the code in there is hard to follow and not very well extracted, this should be fixed :)
* Better dependency injection
* Test `JSONAPIHelpers::Serializer` (currently those tests areas in the parent repos tests

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buren/jsonapi_helpers/issues.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
