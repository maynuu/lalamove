# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'net/http'
require 'httparty'

module Lalamove
  module Helper
    def self.request(path, method, payload={})
      timestamp = get_timestamp
      opts = payload.to_json.to_s
      signature = generate_signature(path, method, timestamp, opts)
      token = get_token(Lalamove.config.key, timestamp, signature)
      headers = get_header(token, timestamp.to_s)
      url = request_url(path)
      if method == 'POST'
        HTTParty.post(url, :headers => headers, :body => opts)
      elsif method == 'GET'
        HTTParty.get(url, :headers => headers)
      else
        HTTParty.put(url, :headers => headers)
      end
    end

    def self.generate_signature(path, method, timestamp, payload)
      raw_signature = generate_raw_signature(method, timestamp, path, payload)
      OpenSSL::HMAC.hexdigest('sha256', Lalamove.config.secret_key, raw_signature)
    end

    def self.generate_raw_signature(method, timestamp,path, payload)
      "#{timestamp}\r\n#{method}\r\n#{path}\r\n\r\n#{payload}"
    end

    def self.get_timestamp
      (Time.now.to_f * 1000).to_i
    end

    def self.get_header(token, timestamp)
      {
        "Authorization" => "hmac #{token}",
        "X-LLM-Country" => Lalamove.config.country_code,
        "X-Request-ID" => timestamp.to_s
      }
    end

    def self.get_token(key, timestamp, signature)
      "#{key}:#{timestamp}:#{signature}"
    end

    def self.request_url(path)
      Lalamove::Config.base_url + path
    end
  end
end
