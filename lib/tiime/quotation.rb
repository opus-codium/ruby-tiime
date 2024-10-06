# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Quotation < BaseModel
    request_body_type :json

    get :all, '/companies/#company_id/quotations'
    get :find, '/companies/#company_id/quotations/:id'
    get :pdf, '/companies/#company_id/quotations/:id/pdf', plain: true
    patch :update, '/companies/#company_id/quotations/:id', only_changed: true

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end
  end
end
