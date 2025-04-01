# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require "logger"

# This should maybe be moved to a gem?
require_relative '../search-engine/lib/card_database'
$CardDatabase = CardDatabase.load
