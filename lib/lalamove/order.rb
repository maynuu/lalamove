# frozen_string_literal: true

require 'lalamove/helper'

module Lalamove
  class API
    # Order 
    class Order
      def self.order(payload)
        Helper.request('/v2/orders', payload, 'POST')
      end

      def self.order_detail(id)
        Helper.request("/v2/orders/#{id}", nil, 'GET')
      end

      def self.driver_details(id, driver_id)
        Helper.request("/v2/orders/#{id}/drivers/#{driver_id}", nil, 'GET')
      end

      def self.driver_location(id, driver_id)
        Helper.request("/v2/orders/#{id}/drivers/#{driver_id}/location", nil, 'GET')
      end

      def self.cancel_order(id)
        Helper.request("/v2/orders/#{id}/cancel", nil, 'PUT')
      end
    end
  end
end
