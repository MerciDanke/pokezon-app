# frozen_string_literal: true

require 'dry-validation'

module MerciDanke
  module Forms
    # Search product with params
    class SearchProduct < Dry::Validation::Contract
      params do
        required(:poke_name).filled(:string)
      end
    end
  end
end
