# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Document < BaseModel
    get :all, '/companies/:company_id/documents'
    get :find, '/companies/:company_id/documents/:id'
    get :download, '/companies/:company_id/documents/:id/file', plain: true
  end
end
