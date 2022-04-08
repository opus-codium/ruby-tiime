# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Invoice < BaseModel
    get :all, '/companies/:company_id/invoices'
    get :find, '/companies/:company_id/invoices/:id'
  end
end
