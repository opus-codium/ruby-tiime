# frozen_string_literal: true

require 'tiime/base_model'
require 'tiime/bank_account'
require 'tiime/customer'

module Tiime
  class Company < BaseModel
    get :all, '/companies'
    get :find, '/companies/:id'

    before_request :cache_refresh
    def cache_refresh(name, request)
      BaseModel.invalidate_cache_for(self, request) if Tiime.cache_strategy == :force_refresh
      nil
    end

    def customers
      Customer.all company_id: id
    end

    def bank_accounts
      BankAccount.all company_id: id
    end
  end
end
