# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  Dir[Rails.root.join('spec/shared_examples/**/*.rb')].each { |f| require f }

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.infer_spec_type_from_file_location!
end
