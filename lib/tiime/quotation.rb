# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Quotation < BaseModel
    get :all, '/companies/#company_id/quotations'
    get :find, '/companies/#company_id/quotations/:id'
    get :pdf, '/companies/#company_id/quotations/:id/pdf', plain: true

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end
  end
end
