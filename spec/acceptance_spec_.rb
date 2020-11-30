# frozen_string_literal: true

require_relative 'helpers/spec_helper'
require_relative 'helpers/database_helper'
require_relative 'helpers/vcr_helper'
# if ENV['HEADLESS'] == 'on'
#   require 'headless'
#   headless = Headless.new
#   headless.start
# end
require 'headless'
require 'watir'
require 'selenium-webdriver'

describe 'Acceptance Tests' do
  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    @browser = Watir::Browser.new :firefox, headless: true
    @homepage = 'http://localhost:9292/'
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Homepage' do
    describe 'Visit Home page' do
      it '(HAPPY) should not see advance search selections if not click' do
        # GIVEN: user is on the home page
        @browser.goto @homepage

        # THEN: user should see basic headers and a welcome message
        _(@browser.h1(id: 'main_header').text).must_equal 'PokéZon'
        _(@browser.text_field(id: 'pokemon_input').present?).must_equal true
        _(@browser.button(id: 'products_form_submit').present?).must_equal true
        _(@browser.button(id: 'advance_button').present?).must_equal true
        _(@browser.div(id: 'flash_bar_success').present?).must_equal true
        _(@browser.div(id: 'flash_bar_success').text.downcase).must_include 'start'
      end

      it '(HAPPY) should be able to see advance search selections' do
        # GIVEN: user is on the home page
        @browser.goto homepage

        # WHEN: they click the advance button
        @browser.button(id: 'advance_button').click
        _(@browser.button(id: 'repo-form-submit').present?).must_equal true
      end
    end
    describe 'Add Product' do
      it '(HAPPY) should be able to request a product' do
        # GIVEN: user is on the home page
        @browser.goto homepage

        # WHEN: they add a pokemon name and submit
        good_url = "#{POKE_NAME}"
        @browser.text_field(id: 'pokemon_input').set(good_url)
        @browser.button(id: 'products_form_submit').click

        # THEN: they should find the pokemon on the product's page
        @browser.url.include? POKE_NAME
      end

      it '(BAD) should not be able to add an invalid pokemon name' do
        # GIVEN: user is on the home page
        @browser.goto homepage

        # WHEN: they request a product with an invalid pokemon name
        bad_name = 'foobar'
        @browser.text_field(id: 'pokemon_input').set(bad_name)
        @browser.button(id: 'products_form_submit').click

        # THEN: they should see a warning message
        _(@browser.div(id: 'flash_bar_danger').text.downcase).must_include 'could not find'
      end
    end
  end
end
