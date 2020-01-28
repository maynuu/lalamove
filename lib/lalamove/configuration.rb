# frozen_string_literal: true

# Lalamove
module Lalamove
  # Configuration
  class Configuration
    attr_accessor :key, :secret_key, :country_code
    attr_writer :base_url, :mode
  end

  SANDBOX_BASE_URL = 'https://sandbox-rest.lalamove.com'
  PROD_BASE_URL = 'https://rest.lalamove.com'

  def self.base_url
    puts "test"
    return @base_url unless @base_url.nil?
    return SANDBOX_BASE_URL if @mode == :sandbox

    PROD_BASE_URL
  end

  def self.mode
    return @mode unless @mode.nil?

    :sandbox
  end
end
