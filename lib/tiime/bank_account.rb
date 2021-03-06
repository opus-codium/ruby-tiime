# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class BankAccount < BaseModel
    get :all, '/companies/#company_id/bank_accounts'
  end
end
