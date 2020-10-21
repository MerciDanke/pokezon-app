# frozen_string_literal: true

require 'net/http'
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
      class NotFound < StandardError; end
    end

    # HTTP_ERROR = {
    #   404 => Errors::NotFound
    # }.freeze

    def pokemon(pokemon_id)
      # pokemon api url
      pokemon_req_url = pk_api_path(pokemon_id)
      pokemon_data = call_pk_url(pokemon_req_url)
      # sprites api url
      sprites_req_url = pkform_api_path(pokemon_id)
      sprites_data = call_pk_url(sprites_req_url)
      # species api url
      species_req_url = pksp_api_path(pokemon_id)
      species_data = call_pk_url(species_req_url)
      Pokemon.new(pokemon_data, species_data, sprites_data)

      # Pokemon.new(pokemon_data, self)
    end

    def sprites(sprites_url)
      sprites_data = call_pk_url(sprites_url)
      sprites_data.map { |data| Sprites.new(data) }
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
      JSON.parse(Net::HTTP.get(URI(url)))
      # result = JSON.parse(Net::HTTP.get(URI(url)))
      # successful?(result) ? result : raise(HTTP_ERROR)
    end

    # def successful?(result)
    #   HTTP_ERROR.keys.include?(result.code) ? false : true
    # end
  end
end
