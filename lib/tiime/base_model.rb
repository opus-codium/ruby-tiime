# frozen_string_literal: true

require 'flexirest'

module Tiime
  class BaseModel < Flexirest::Base
    base_url 'https://chronos-api.tiime-apps.com/v1'

    Flexirest::Base.faraday_config do |faraday|
      faraday.adapter(:net_http)
      faraday.options.timeout       = 10
      faraday.headers['User-Agent'] = "Flexirest/#{Flexirest::VERSION}"
      faraday.headers['Connection'] = "Keep-Alive"
      faraday.headers['Accept']     = "application/json"
      faraday.request :gzip
    end

    before_request :set_bearer
    def set_bearer(_name, request)
      request.headers['Authorization'] = "Bearer #{ENV.fetch('TIIME_TOKEN', nil)}"
    end

    before_request :fill_company_id
    def fill_company_id(_name, request)
      return unless request.url.include? '#company_id'

      company_id = request.get_params[:company_id] if request.get_params.key? :company_id
      request.get_params = request.get_params.slice :company_id

      company_id ||= Tiime.default_company_id.to_s

      if company_id.nil?
        raise Flexirest::MissingParametersException,
              "The following parameters weren't specifed: company_id"
      end

      request.url['#company_id'] = company_id.to_s
    end

    after_request :cache
    def cache(name, response)
      response.response_headers['Expires'] = 1.hour.from_now.iso8601 if %i[all find].include? name
    end

    def self.invalidate_cache_for(sender, request)
      cache_key = "#{sender.class.name}:#{request.url}"
      Flexirest::Logger.debug("  \033[1;4;32m#{Flexirest.name}\033[0m No cache for key: #{cache_key}") unless Flexirest::Base.cache_store.exist? cache_key
      Flexirest::Logger.info("  \033[1;4;32m#{Flexirest.name}\033[0m Invalidating cache for key: #{cache_key}")
      Flexirest::Base.cache_store.delete cache_key
    end
  end
end
