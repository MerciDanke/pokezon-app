# frozen_string_literal: true

module Views
  # View object to capture progress bar information
  class ProductsProcessing
    def initialize(config, response)
      @config = config
      @response = response
    end

    def in_progress?
      @response.processing?
    end

    def ws_channel_id
      @response.message if in_progress?
    end

    def ws_javascript
      @config.API_HOST + '/faye/faye.js' if in_progress?
    end

    def ws_route
      @config.API_HOST + '/faye/faye' if in_progress?
    end
  end
end
