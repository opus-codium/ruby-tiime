# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class DocumentCategory < BaseModel
    get :all, '/companies/:company_id/document_categories'
    get :find, '/companies/:company_id/document_categories/:id'
  end
end
