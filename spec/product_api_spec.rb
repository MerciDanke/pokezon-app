# frozen_string_literal: false

require_relative 'spec_helper_product'

describe 'Tests Product API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<API_KEY>') { API_KEY }
    c.filter_sensitive_data('<API_KEY_ESC>') { CGI.escape(API_KEY) }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Product information' do
    it 'HAPPY: should provide correct product datatype' do
      producttest = ProductInf::ProductApi.new.product(POKENAME)
      puts _(producttest.raw_price.class)
      _(producttest.title.class).must_equal String
      _(producttest.link.class).must_equal String
      _(producttest.image.class).must_equal String
      _(producttest.rating.class).must_equal Float
      _(producttest.ratings_total.class).must_equal Integer
      # _(producttest.raw_price.class).must_equal String
      # _(producttest.currency.class).must_equal String
    end
  end
end
