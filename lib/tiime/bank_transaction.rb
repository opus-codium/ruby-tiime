# frozen_string_literal: true

require 'tiime/base_model'
require 'tiime/receipt'
require 'tiime/document'

module Tiime
  class BankTransaction < BaseModel
    get :all, '/companies/:company_id/bank_transactions', has_many: { receipts: Receipt }
    get :find, '/companies/:company_id/bank_transactions/:id', has_many: { documents: Document }
  end
end
