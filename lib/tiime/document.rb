# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Document < BaseModel
    class Category < BaseModel
      get :all, '/companies/#company_id/document_categories'
      get :find, '/companies/#company_id/document_categories/:id'

      before_request :cache_refresh
      def cache_refresh(name, request)
        invalidate_cache_for self, request if Tiime.cache_strategy == :force_refresh
        nil
      end
    end

    class Metadata < BaseModel; end

    has_many :metadata, Metadata
    has_one :category, Category

    get :all, '/companies/#company_id/documents'
    get :find, '/companies/#company_id/documents/:id'
    get :download, '/companies/#company_id/documents/:id/file', plain: true
    post :create, '/companies/#company_id/document_categories/:category_id/documents',
         request_body_type: :form_multipart, timeout: 120
    patch :update, '/companies/#company_id/documents/:id', request_body_type: :json

    before_request :cache_cleanup
    def cache_cleanup(name, request)
      # TODO: Be more selective
      BaseModel.invalidate_cache_for(self, request) if %i[create update].include? name
      nil
    end

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end
  end
end
