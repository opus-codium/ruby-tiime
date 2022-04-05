# frozen_string_literal: true

require 'tiime/base_model'
require 'tiime/bank_account'
require 'tiime/customer'

class Company < BaseModel
  get :all, '/companies'
  get :find, '/companies/:id'

  def customers
    Customer.all company_id: id
  end

  def bank_accounts
    BankAccount.all company_id: id
  end
end
