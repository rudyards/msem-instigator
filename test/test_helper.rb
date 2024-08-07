# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'capybara/rails'

module ActiveSupport
  class TestCase
    # Add more helper methods to be used by all tests here...
  end
end

module ActionDispatch
  class IntegrationTest
    # Make the Capybara DSL available in all integration tests
    include Capybara::DSL

    # Reset sessions and driver between tests
    # Use super wherever this method is redefined in your individual test classes
    def teardown
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end

Capybara.default_driver = :webkit
