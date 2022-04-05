# frozen_string_literal: true

require 'flexirest'

class BaseModel < Flexirest::Base
  base_url 'https://chronos-api.tiime-apps.com/v1'

  before_request :set_bearer

  def set_bearer(_name, request)
    request.headers['Authorization'] = "Bearer #{ENV['TIIME_TOKEN']}"
  end
end
