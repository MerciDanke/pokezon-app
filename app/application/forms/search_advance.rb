# frozen_string_literal: true

require 'dry-validation'

module MerciDanke
  module Forms
    # SearchProduct
    class SearchAdvance < Dry::Validation::Contract
      params do
        required(:color).filled(:string)
        required(:type).filled(:string)
        required(:habitat).filled(:string)
        required(:low_h).filled(:string)
        required(:high_h).filled(:string)
        required(:low_w).filled(:string)
        required(:high_w).filled(:string)
      end
    end
  end
end
