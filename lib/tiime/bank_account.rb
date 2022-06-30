# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class BankAccount < BaseModel
    get :all, '/companies/#company_id/bank_accounts'

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end
  end
end
