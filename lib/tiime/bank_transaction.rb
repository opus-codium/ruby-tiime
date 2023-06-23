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

    get :all, '/companies/#company_id/bank_transactions', timeout: 120
    get :find, '/companies/#company_id/bank_transactions/:id'
    post :upload_receipt, '/companies/#company_id/bank_transactions/:id/receipts', request_body_type: :form_multipart

    before_request :cache_cleanup
    def cache_cleanup(name, request)
      # TODO: Be more selective
      BaseModel.invalidate_cache_for(self, request) if %i[upload_receipt].include? name
      nil
    end

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end

    def vat_amount
      return nil if count_receipts.zero?

      receipt_documents = documents.map { |document| Tiime::Document.find document.id }

      receipt_documents.inject(0.0) do |memo, receipt|
        receipt.metadata.find { |m| m.key == 'vat_amount' }.value.items.find { |i| i.key == 'total' }.value.value
        receipt_vat_amount = receipt.metadata.find { |m| m.key == 'vat_amount' }&.value&.items.find { |i| i.key == 'total' }&.value&.value
        receipt_vat_amount ||= 0
        memo + receipt_vat_amount
      end
    end
  end
end
