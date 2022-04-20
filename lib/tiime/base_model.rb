# frozen_string_literal: true

require 'flexirest'

module Tiime
  class BaseModel < Flexirest::Base
    base_url 'https://chronos-api.tiime-apps.com/v1'

    before_request :set_bearer
    def set_bearer(_name, request)
      request.headers['Authorization'] = "Bearer #{ENV['TIIME_TOKEN']}"
    end

    before_request :fill_company_id
    def fill_company_id(_name, request)
      return unless request.url.include? '#company_id'

      company_id = request.get_params[:company_id] if request.get_params.has_key? :company_id
      request.get_params = request.get_params.slice :company_id

      company_id ||= Tiime.default_company_id.to_s

      raise Flexirest::MissingParametersException, "The following parameters weren't specifed: company_id" if company_id.nil?

      request.url['#company_id'] = company_id.to_s
    end
  end
end
