# frozen_string_literal: true

require 'http'
require 'json'
require_relative 'pokemon'
require_relative 'sprites'
require_relative 'species'

module PokemonInf
  # Library for Pokemon API
  class PokemonApi
    API_POKEMON_ROOT = 'https://pokeapi.co/api/v2/pokemon'
    API_SPECIES_ROOT = 'https://pokeapi.co/api/v2/pokemon-species'
    API_FORM_ROOT = 'https://pokeapi.co/api/v2/pokemon-form'

    module Errors
      # Notfound error
      class NotFound < StandardError; end
    end
    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    def pokemon(pokemon_id)
      # pokemon api url
      pokemon_data = call_pk_url(pk_api_path(pokemon_id))
      # sprites api url
      sprites_data = call_pk_url(pkform_api_path(pokemon_id))
      # species api url
      species_data = call_pk_url(pksp_api_path(pokemon_id))
      Pokemon.new(pokemon_data, species_data, sprites_data)
    end

    private

    def pk_api_path(path)
      "#{API_POKEMON_ROOT}/#{path}"
    end

    def pksp_api_path(path)
      "#{API_SPECIES_ROOT}/#{path}"
    end

    def pkform_api_path(path)
      "#{API_FORM_ROOT}/#{path}"
    end

    def call_pk_url(url)
      result = HTTP.get(url)
      successful?(result) ? JSON.parse(result) : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      HTTP_ERROR.keys.include?(result.code) ? false : true
    end
  end
end
