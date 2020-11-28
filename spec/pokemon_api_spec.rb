# frozen_string_literal: false

require_relative 'helpers/spec_helper'

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
      # pokemontest = PokemonInf::PokemonApi.new.pokemon(ID)
      pokemontest = MerciDanke::Pokemon::PokemonMapper.new.find(ID)
      _(pokemontest.id).must_equal CORRECT['id']
      _(pokemontest.name).must_equal CORRECT['name']
      _(pokemontest.type).must_equal CORRECT['type']
      # _(pokemontest.abilities).must_equal CORRECT['abilities']
      _(pokemontest.abilities).must_be_kind_of Array
      _(pokemontest.evo_chains).must_be_kind_of MerciDanke::Entity::EvoChain
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
    it 'SAD: should raise exception on incorrect id' do
      _(proc do
        MerciDanke::Pokemon::PokemonMapper.new.find('foobar')
      end).must_raise MerciDanke::Pokemon::Api::Response::NotFound
    end
  end
end
