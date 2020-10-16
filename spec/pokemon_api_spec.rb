# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/poke_lib/pokemon_api'

ID = '1'.freeze
CORRECT = YAML.safe_load(File.read('spec/fixtures/poke_data/poke1_results.yml'))

describe 'Tests Pokemon API library' do
  describe 'Pokemon information' do
    it 'HAPPY: should provide correct pokemon attributes' do
      pokemon = PokemonInf::PokemonApi.new.pokemon(ID)
      _(pokemon.id).must_equal CORRECT['id']
      _(pokemon.name).must_equal CORRECT['name']
      _(pokemon.type).must_equal CORRECT['type']
      _(pokemon.abilities).must_equal CORRECT['abilities']
      _(pokemon.height).must_equal CORRECT['height']
      _(pokemon.weight).must_equal CORRECT['weight']
      _(pokemon.back_defult).must_equal CORRECT['back_defult']
      _(pokemon.back_shiny).must_equal CORRECT['back_shiny']
      _(pokemon.front_defult).must_equal CORRECT['front_defult']
      _(pokemon.front_shiny).must_equal CORRECT['front_shiny']
      _(pokemon.habitat).must_equal CORRECT['habitat']
      _(pokemon.color).must_equal CORRECT['color']
      _(pokemon.flavor_text_entries).must_equal CORRECT['flavor_text_entries']
      _(genera).must_equal CORRECT['genera']
    end

    it 'SAD: should raise exception on incorrect id' do
      _(proc do
        PokemonInf::PokemonApi.new.pokemon('foobar')
      end).must_raise PokemonInf::PokemonApi::Errors::NotFound
    end
  end

  describe 'Sprites information' do
    before do
      @pokemon = PokemonInf::PokemonApi.new.pokemon(ID)
    end

    it 'HAPPY: should recognize sprites' do
      _(@pokemon.sprites).must_be_kind_of PokemonInf::Sprites
    end

    it 'HAPPY: should identify sprites' do
      _(@pokemon.sprites.back_default).wont_be_nil
      _(@pokemon.sprites.back_default).must_equal CORRECT['sprites']['back_default']
      _(@pokemon.sprites.back_shiny).wont_be_nil
      _(@pokemon.sprites.back_shiny).must_equal CORRECT['sprites']['back_shiny']
      _(@pokemon.sprites.front_default).wont_be_nil
      _(@pokemon.sprites.front_default).must_equal CORRECT['sprites']['front_default']
      _(@pokemon.sprites.front_shiny).wont_be_nil
      _(@pokemon.sprites.front_shiny).must_equal CORRECT['sprites']['front_shiny']
    end
  end
end
