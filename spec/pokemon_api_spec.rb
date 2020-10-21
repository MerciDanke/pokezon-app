# frozen_string_literal: false

require_relative 'spec_helper'

describe 'Tests Pokemon API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end
  describe 'Pokemon information' do
    it 'HAPPY: should provide correct pokemon attributes' do
      pokemontest = PokemonInf::PokemonApi.new
      pokemontest = pokemontest.pokemon(ID)
      _(pokemontest.id).must_equal CORRECT['id']
      _(pokemontest.name).must_equal CORRECT['name']
      _(pokemontest.type).must_equal CORRECT['type']
      _(pokemontest.abilities).must_equal CORRECT['abilities']
      _(pokemontest.height).must_equal CORRECT['height']
      _(pokemontest.weight).must_equal CORRECT['weight']
      _(pokemontest.habitat).must_equal CORRECT['habitat']
      _(pokemontest.color).must_equal CORRECT['color']
      _(pokemontest.flavor_text_entries).must_equal CORRECT['flavor_text_entries']
      _(pokemontest.genera).must_equal CORRECT['genera']
      _(pokemontest.back_default).must_equal CORRECT['back_default']
      _(pokemontest.back_shiny).must_equal CORRECT['back_shiny']
      _(pokemontest.front_default).must_equal CORRECT['front_default']
      _(pokemontest.front_shiny).must_equal CORRECT['front_shiny']
    end

    # it 'SAD: should raise exception on incorrect id' do
    #   _(proc do
    #     PokemonInf::PokemonApi.new.pokemon('foobar')
    #   end).must_raise PokemonInf::PokemonApi::Errors::NotFound
    # end
  end

  # describe 'Sprites information' do
  #   before do
  #     @pokemon = PokemonInf::PokemonApi.new.pokemon(ID)
  #   end

  #   it 'HAPPY: should recognize sprites' do
  #     _(@pokemon.sprites).must_be_kind_of PokemonInf::Sprites
  #   end

  #   it 'HAPPY: should identify sprites' do
  #     _(@pokemon.sprites.back_default).wont_be_nil
  #     _(@pokemon.sprites.back_default).must_equal CORRECT['sprites']['back_default']
  #     _(@pokemon.sprites.back_shiny).wont_be_nil
  #     _(@pokemon.sprites.back_shiny).must_equal CORRECT['sprites']['back_shiny']
  #     _(@pokemon.sprites.front_default).wont_be_nil
  #     _(@pokemon.sprites.front_default).must_equal CORRECT['sprites']['front_default']
  #     _(@pokemon.sprites.front_shiny).wont_be_nil
  #     _(@pokemon.sprites.front_shiny).must_equal CORRECT['sprites']['front_shiny']
  #   end
  # end
end
