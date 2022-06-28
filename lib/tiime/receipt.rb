# frozen_string_literal: true

require 'tiime'

module Tiime
  module Receipt
    def date
      m = metadata.find { |m| m.key == 'date' }
      return nil if m.nil?

      return m.value if m.value.is_a? DateTime

      DateTime.strptime m.value, '%a %b %d %Y'
    end

    def date=(value)
      value = value.strftime('%a %b %d %Y')

      m = metadata.find { |m| m.key == 'date' }
      if m.nil?
        metadata << { key: 'date', type: 'datetime', value: value }
      else
        m.value = value
      end
    end

    def label
      metadata.find { |m| m.key == 'wording' }&.value
    end

    def label=(value)
      m = metadata.find { |m| m.key == 'wording' }
      if m.nil?
        metadata << { key: 'wording', type: 'string', value: label }
      else
        m.value = value
      end
    end

    def amount
      metadata.find { |m| m.key == 'amount' }&.value&.value
    end

    def amount=(value)
      m = metadata.find { |m| m.key == 'amount' }
      if m.nil?
        metadata << { key: 'amount', type: 'amount', value: { currency: 'EUR', value: value } }
      else
        m.value.value = value
      end
    end

    def vat_amount
      metadata.find { |m| m.key == 'vat_amount' }&.value&.value
    end

    def vat_amount=(value)
      m = metadata.find { |m| m.key == 'vat_amount' }
      if m.nil?
        metadata << { key: 'vat_amount', type: 'vat_amount', value: { currency: 'EUR', value: value } }
      else
        m.value.value = value
      end
    end

    class << self
      def upload(file:, label:, date:, amount:, vat_amount:, company_id: nil, bank_transaction_id: nil)
        if company_id.nil?
          raise 'Please provide a company_id or set default company ID (ie. Tiime.default_company_id)' if Tiime.default_company_id.nil?

          company_id = Tiime.default_company_id
        end

        date = date.strftime('%a %b %d %Y')

        metadata = [
          { key: 'date', type: 'datetime', value: date },
          { key: 'wording', type: 'string', value: label },
          { key: 'amount', type: 'amount', value: { currency: 'EUR', value: amount } },
          { key: 'vat_amount', type: 'amount', value: { currency: 'EUR', value: vat_amount } },
        ]

        # Creation
        document = if bank_transaction_id.nil?
                     Tiime::Document.create company_id: company_id,
                                            category_id: Tiime::Receipt.category.id,
                                            file: file
                   else
                     Tiime::BankTransaction.upload_receipt id: bank_transaction_id,
                                                           file: file
                   end

        # Add metadata
        Tiime::Document.update id: document.id, company_id: company_id, metadata: metadata
      end

      def category
        return @category unless @category.nil?

        raise 'Unable to guess receipt category: no default company ID provided (ie. Tiime.default_company_id)' if Tiime.default_company_id.nil?

        @category = Tiime::Document::Category.all(company_id: Tiime.default_company_id).where(name: 'Justificatifs').first
      end
    end
  end
end
