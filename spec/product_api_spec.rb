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
    it 'HAPPY: should provide correct product attributes' do
      puts POKENAME
      producttest = ProductInf::ProductApi.new.product(POKENAME)
      _(producttest.title).must_equal CORRECT[3]['title']
      _(producttest.link).must_equal CORRECT[3]['link']
      _(producttest.image).must_equal CORRECT[3]['image']
      _(producttest.rating).must_equal CORRECT[3]['rating']
      _(producttest.ratings_total).must_equal CORRECT[3]['ratingsTotal']
      _(producttest.raw_price).must_equal CORRECT[3]['rawPrice']
      _(producttest.currency).must_equal CORRECT[3]['currency']
    end
    it 'SAD: should raise exception on incorrect id' do
      _(proc do
        ProductInf::ProductApi.new.product('foobar')
      end).must_raise ProductInf::ProductApi::Errors::NotFound
    end
  end
end
