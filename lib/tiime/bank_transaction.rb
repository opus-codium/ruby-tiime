# frozen_string_literal: true

require 'tiime/bank_account'
require 'tiime/base_model'
require 'tiime/customer'
require 'tiime/document'
require 'tiime/invoice'

module Tiime
  class BankTransaction < BaseModel
    has_one  :bank_account, BankAccount
    has_many :receipts, Document
    has_many :documents, Document
    has_many :invoices, Invoice
    has_many :clients, Customer

    get :all, '/companies/:company_id/bank_transactions'
    get :find, '/companies/:company_id/bank_transactions/:id'
  end
end
