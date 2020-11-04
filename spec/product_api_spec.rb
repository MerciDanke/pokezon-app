# frozen_string_literal: false

require_relative 'spec_helper_product'
require_relative 'helpers/vcr_helper'

describe 'Tests Product API library' do
  before do
    VcrHelper.configure_vcr_for_apikey
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Product information' do
    it 'HAPPY: should provide correct product datatype' do
      producttest =
        MerciDanke::Amazon::ProductMapper.new.find(POKENAME, API_KEY)
      puts producttest.title
      _(producttest.title.class).must_equal String
      _(producttest.link.class).must_equal String
      _(producttest.image.class).must_equal String
      _(producttest.rating.class).must_equal Float
      _(producttest.ratings_total.class).must_equal Integer
      # _(producttest.price.class).must_equal Float
      # _(producttest.currency.class).must_equal String
    end
  end
end
