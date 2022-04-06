# frozen_string_literal: true

require 'tiime/base_model'

module Tiime
  class Customer < BaseModel
    get :all, '/companies/:company_id/clients'
  end
end
