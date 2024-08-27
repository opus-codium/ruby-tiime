# frozen_string_literal: true

module Tiime
  class User < BaseModel
    get :me, '/users/me'

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end
  end
end
