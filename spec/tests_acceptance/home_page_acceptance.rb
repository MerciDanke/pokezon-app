# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/home_page'

describe 'Homepage Acceptance Tests' do
  include PageObject::PageFactory

  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    @browser = Watir::Browser.new :firefox, headless: true
  end

  after do
    @browser.close
  end

  describe 'Visit Home page' do
    it '(HAPPY) should see pokemons on home page' do
      # WHEN: they visit the home page
      visit HomePage do |page|
        # THEN: they should see basic headers, no projects and a welcome message
        _(page.title_heading).must_equal 'PokéZon'
        _(page.poke_name_input_element.present?).must_equal true
        _(page.add_products_button_element.present?).must_equal true
        _(page.advance_button_element.present?).must_equal true
        _(page.first_pokemon.text).must_include POKE_NAME
        _(page.pokemon_link_element.present?).must_equal true

        _(page.success_message_element.present?).must_equal true
        _(page.success_message.downcase).must_include 'start'
      end
    end
  end

  describe 'Add Products' do
    it '(HAPPY) should be able to request a product' do
      # GIVEN: user is on the home page
      visit HomePage do |page|
        # WHEN: they add a pokemon's name and submit
        good_poke_name = "#{POKE_NAME}"
        page.add_new_products(good_poke_name)

        # THEN: they should find the pokemon on the product's page
        @browser.url.include? POKE_NAME
      end
    end

    it '(BAD) should not be able to add an invalid pokemon name' do
      # GIVEN: user is on the home page
      visit HomePage do |page|
        # WHEN: they request pokemon's products with an invalid pokemon's name
        bad_name = 'foobar'
        page.add_new_products(bad_name)

        # THEN: they should see a warning message
        _(page.warning_message.downcase).must_include 'could not find'
      end
    end
  end
end
