# frozen_string_literal: false

require 'http'
require 'json'
require_relative 'evolution_chain'

module EvolutionChainInf
  # Library for Pokemon Ability API
  class EvoluChainApi
    API_EVO_ROOT = 'https://pokeapi.co/api/v2/evolution-chain'.freeze

    module Errors
      # Notfound error
      class NotFound < StandardError; end
    end
    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    def evolution(evolution_id)
      # evolution chain api url
      evolution_data = call_evo_url(evo_api_path(evolution_id))
      EvolutionChain.new(evolution_data)
    end

    private

    def evo_api_path(path)
      "#{API_EVO_ROOT}/#{path}"
    end

    def call_evo_url(url)
      result = HTTP.get(url)
      successful?(result) ? JSON.parse(result) : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      HTTP_ERROR.keys.include?(result.code) ? false : true
    end
  end
end
