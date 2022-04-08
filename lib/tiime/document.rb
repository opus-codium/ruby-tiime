# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Document < BaseModel

    class Category < BaseModel
      get :all, '/companies/:company_id/document_categories'
      get :find, '/companies/:company_id/document_categories/:id'
    end

    class Metadata < BaseModel; end

    has_many :metadata, Metadata
    has_one :category, Category

    get :all, '/companies/:company_id/documents'
    get :find, '/companies/:company_id/documents/:id'
    get :download, '/companies/:company_id/documents/:id/file', plain: true
    post :create, '/companies/:company_id/document_categories/:category_id/documents', request_body_type: :form_multipart
    patch :update, '/companies/:company_id/documents/:id', request_body_type: :json
  end
end
