# frozen_string_literal: true

require 'faraday/gzip'

require 'tiime/bank_account'
require 'tiime/bank_transaction'
require 'tiime/company'
require 'tiime/customer'
require 'tiime/document'
require 'tiime/invoice'
require 'tiime/receipt'

require 'tiime/version'

module Tiime
  class Error < StandardError; end

  class << self
    attr_accessor :default_company_id

    attr_writer :cache_strategy
    def cache_strategy
      @cache_strategy ||= :lazy_cache
    end
  end
end
