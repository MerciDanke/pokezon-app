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

# Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"binary" => "/usr/lib/chromium-browser/chromedriver"})
# @drive = Selenium::WebDriver.for :chrome, options: options
describe 'Acceptance Tests' do
  DatabaseHelper.setup_database_cleaner

  before do
    # args = ['--disable-dev-shm-usage', '--no-sandbox']
    DatabaseHelper.wipe_database
    # @headless = Headless.new
    # @headless.start
    # options = Selenium::WebDriver::Chrome::Options.new
    # options.add_argument("--disable-dev-shm-usage");
    # options.add_argument('--no-sandbox')
    # options.add_argument('--headless')
    # caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"binary" => "/usr/lib/chromedriver"})
    # driver = Selenium::WebDriver::Driver.for :chrome, options: options, desired_capabilities: caps
    # driver = Selenium::WebDriver::Driver.for(:remote, url: "http://localhost:9292")
    @browser = Watir::Browser.new :firefox, headless: true
    @homepage = 'http://localhost:9292/'
    # @browser = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"binary" => "/usr/lib/chromium-browser/chromedriver"})
    # @browser = Selenium::WebDriver.for :chrome, options: options, binary:"/usr/lib/chromedriver"
    # @browser = Selenium::WebDriver.for :chrome, options: options, desired_capabilities: caps
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Homepage' do
    describe 'Visit Home page' do
      it '(HAPPY) should not see projects if none created' do
        # GIVEN: user is on the home page without any projects
        @browser.goto @homepage

        pokemon = MerciDanke::Pokemon::PokemonMapper.new.find(POKE_NAME)
        # rebuilt = MerciDanke::SearchRecord::ForPoke.entity(pokemon).create(pokemon)
        # THEN: user should see basic headers, no projects and a welcome message
        # _(@browser.select(id: 'type_name_select').present?).must_equal true
        # _(@browser.select(id: 'habitat_name_select').present?).must_equal true
        # _(@browser.button(id: 'repo-form-submit').present?).must_equal true
        # pokemon likes
        _(@browser.input(id: "#{pokemon.id}").present?).must_equal true
        _(@browser.div(id: 'flash_bar_success').present?).must_equal true
        _(@browser.div(id: 'flash_bar_success').text.downcase).must_include 'start'
      end
    end
  end
end
