# frozen_string_literal: false

require 'http'
require 'json'
require_relative 'ability'

module AbilityInf
  # Library for Pokemon Ability API
  class AbilityApi
    API_ABILITY_ROOT = 'https://pokeapi.co/api/v2/ability'.freeze

    module Errors
      # Notfound error
      class NotFound < StandardError; end
    end
    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    def ability(ability_id)
      # ability api url
      ability_data = call_ability_url(ability_api_path(ability_id))
      Ability.new(ability_data)
    end

    private

    def ability_api_path(path)
      "#{API_ABILITY_ROOT}/#{path}"
    end

    def call_ability_url(url)
      result = HTTP.get(url)
      successful?(result) ? JSON.parse(result) : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      HTTP_ERROR.keys.include?(result.code) ? false : true
    end
  end
end
