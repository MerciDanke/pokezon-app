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
      pokemontest = PokemonInf::PokemonApi.new.pokemon(ID)
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
    it 'SAD: should raise exception on incorrect id' do
      _(proc do
        PokemonInf::PokemonApi.new.pokemon('foobar')
      end).must_raise PokemonInf::PokemonApi::Errors::NotFound
    end
  end
  describe 'Pokemon other information' do
    it 'HAPPY: should provide correct ability attributes' do
      abilitytest = AbilityInf::AbilityApi.new.ability(ID)
      _(abilitytest.name).must_equal ABILITYCORRECT['name']
      _(abilitytest.pokemon).must_equal ABILITYCORRECT['pokemon']
      _(abilitytest.flavor_text_entries).must_equal ABILITYCORRECT['flavor_text_entries']
    end
    it 'HAPPY: should provide correct evolution chain' do
      evotest = EvolutionChainInf::EvoluChainApi.new.evolution(ID)
      _(evotest.name).must_equal EVOCORRECT['chain_species']
      _(evotest.evolutions_to).must_equal EVOCORRECT['evolves_to']
      # _(evotest.evolutions_to_second).must_equal EVOCORRECT['evolves_to_second']
    end
  end
end
