# frozen_string_literal: true

require 'tiime'

module Tiime
  module Receipt
    class << self
      module RenamableFile
        attr_accessor :path
      end

      def upload(file:, label:, date:, amount:, vat_amount:, filename: nil, company_id: nil)
        if company_id.nil?
          if Tiime.default_company_id.nil?
            raise 'Please provide a company_id or set default company ID (ie. Tiime.default_company_id)'
          end

          company_id = Tiime.default_company_id
        end

        file = File.open(file)

        unless filename.nil?
          file.extend RenamableFile
          file.path = filename
        end

        date = date.strftime('%a %b %d %Y')

        metadata = [
          { key: 'date', type: 'datetime', value: date },
          { key: 'wording', type: 'string', value: label },
          { key: 'vat_amount', type: 'amount', value: { currency: 'EUR', value: vat_amount } },
          { key: 'amount', type: 'amount', value: { currency: 'EUR', value: amount } }
        ]

        # Creation
        document = Tiime::Document.create company_id: company_id,
                                          category_id: Tiime::Receipt.category.id,
                                          file: file
        # Add metadata
        Tiime::Document.update id: document.id, company_id: company_id, metadata: metadata
      end

      def category
        return @category unless @category.nil?

        if Tiime.default_company_id.nil?
          raise 'Unable to guess receipt category: no default company ID provided (ie. Tiime.default_company_id)'
        end

        @category = Tiime::Document::Category.all(company_id: Tiime.default_company_id).where(name: 'Justificatifs').first
      end
    end
  end
end
