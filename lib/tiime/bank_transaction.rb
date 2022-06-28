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

    get :all, '/companies/#company_id/bank_transactions'
    get :find, '/companies/#company_id/bank_transactions/:id'
    post :upload_receipt, '/companies/#company_id/bank_transactions/:id/receipts', request_body_type: :form_multipart

    def vat_amount
      return nil if receipts.count.zero?

      receipt_documents = receipts.map { |receipt| Tiime::Document.find receipt.id }

      receipt_documents.inject(0.0) do |memo, receipt|
        receipt_vat_amount = receipt.metadata.find { |m| m.key == 'vat_amount' }.value.value
        memo + receipt_vat_amount
      end
    end
  end
end
