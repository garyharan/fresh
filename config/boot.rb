ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# allow listening from anywhere
ENV['BINDING'] ||= '0.0.0.0'

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
