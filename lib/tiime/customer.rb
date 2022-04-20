# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Customer < BaseModel
    get :all, '/companies/#company_id/clients'
    get :find, '/companies/#company_id/clients/:id'
  end
end
