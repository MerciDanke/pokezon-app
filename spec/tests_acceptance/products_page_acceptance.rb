# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/products_page'
require_relative 'pages/home_page'

describe 'Products page Acceptance Tests' do
  include PageObject::PageFactory

  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    @browser = Watir::Browser.new :firefox, headless: true
  end

  after do
    @browser.close
  end

  it '(HAPPY) should see products content if products exist' do
    # GIVEN: user adds a pokemon's name and submit, call the amazon products
    visit HomePage do |page|
      good_poke_name = "#{POKE_NAME}"
      page.add_new_products(good_poke_name)
    end
    # WHEN: they go to the product's page
    visit(ProductsPage, using_params: { poke_name: POKE_NAME,}) do |page|
      # THEN: they should see the product details
      _(page.products_title).must_include POKE_NAME
      _(page.pokemon_intro_element.present?).must_equal true
      _(page.pokemon_details_element.present?).must_equal true

      _(page.products[0].product_link).must_equal 'see more'
      _(page.products[0].product_rating_element.present?).must_equal true
    end
  end
end
