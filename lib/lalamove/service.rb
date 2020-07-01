# frozen_string_literal: true

require 'lalamove/helper'

module Lalamove
  # Service
  class API 
    def self.quotation(payload)
      Helper.request('/v2/quotations', 'POST', payload)
    end
  end
end
