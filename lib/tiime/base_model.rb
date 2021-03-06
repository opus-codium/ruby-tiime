# frozen_string_literal: true

require 'flexirest'

module Tiime
  class BaseModel < Flexirest::Base
    base_url 'https://chronos-api.tiime-apps.com/v1'

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
      Flexirest::Logger.info("  \033[1;4;32m#{Flexirest.name}\033[0m Invalidating cache for #{sender.class.name} #{request.url}")
      Flexirest::Base.cache_store.delete("#{self.class.name}:#{request.url}")
    end
  end
end
