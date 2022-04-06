# frozen_string_literal: true

require 'tiime/base_model'
require 'tiime/bank_transaction'

module Tiime
  class BankAccount < BaseModel
    get :all, '/companies/:company_id/bank_accounts'
  end
end
