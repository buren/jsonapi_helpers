# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JSONAPIHelpers do
  it 'has a major version number' do
    expect(JSONAPIHelpers::MAJOR).not_to be nil
  end

  it 'has a minor version number' do
    expect(JSONAPIHelpers::MINOR).not_to be nil
  end

  it 'has a patch version number' do
    expect(JSONAPIHelpers::PATCH).not_to be nil
  end

  it 'has a version number' do
    expect(JSONAPIHelpers::VERSION).not_to be nil
  end
end
