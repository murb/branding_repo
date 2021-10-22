# frozen_string_literal: true

require_relative "branding_repo/version"

module BrandingRepo
  class Error < StandardError; end

  require 'branding_repo/railtie' if defined?(Rails)
  # Your code goes here...
end
