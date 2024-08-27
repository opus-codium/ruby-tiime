# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Contact < BaseModel
    get :all, '/companies/#company_id/clients/:id/contacts'

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end
  end
end
