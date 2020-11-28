# frozen_string_literal: true

require_relative 'helpers/spec_helper'
require_relative 'helpers/database_helper'
require_relative 'helpers/vcr_helper'
require 'headless'
require 'watir'

describe 'Acceptance Tests' do
  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    @headless.destroy
  end

  describe 'Homepage' do
    describe 'Visit Home page' do
      it '(HAPPY) should not see projects if none created' do
        # GIVEN: user is on the home page without any projects
        @browser.goto homepage

        # THEN: user should see basic headers, no projects and a welcome message
        _(@browser.select(id: 'type_name_select').present?).must_equal true
        _(@browser.select(id: 'habitat_name_select').present?).must_equal true
        _(@browser.button(id: 'repo-form-submit').present?).must_equal true
        _(@browser.input(id: ('show' + index.to_s)).present?).must_equal true
      end
    end
  end
end
