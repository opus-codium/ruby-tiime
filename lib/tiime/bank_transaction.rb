# frozen_string_literal: true

require 'tiime/base_model'
require 'tiime/document'
require 'tiime/bank_account'

module Tiime
  class BankTransaction < BaseModel
    get :all, '/companies/:company_id/bank_transactions', has_many: { receipts: Document }, has_one: { bank_account: BankAccount }
    get :find, '/companies/:company_id/bank_transactions/:id', has_many: { documents: Document }
  end
end
