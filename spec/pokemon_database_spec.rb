# frozen_string_literal: false

require_relative 'helpers/spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Pokemon API and Database' do
  VcrHelper.setup_vcr
  DatabaseHelper.setup_database_cleaner

  before do
    VcrHelper.configure_vcr_for_github
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store pokemon' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save pokemon from Pokemon API to database' do
      pokemon = MerciDanke::Pokemon::PokemonMapper.new.find(ID)

      rebuilt = MerciDanke::SearchRecord::ForPoke.entity(pokemon).create(pokemon)

      _(rebuilt.origin_id).must_equal(pokemon.origin_id)
      _(rebuilt.poke_name).must_equal(pokemon.poke_name)
      _(rebuilt.weight).must_equal(pokemon.weight)
      _(rebuilt.height).must_equal(pokemon.height)
      _(rebuilt.back_default).must_equal(pokemon.back_default)
      _(rebuilt.back_shiny).must_equal(pokemon.back_shiny)
      _(rebuilt.front_default).must_equal(pokemon.front_default)
      _(rebuilt.front_shiny).must_equal(pokemon.front_shiny)
      _(rebuilt.habitat).must_equal(pokemon.habitat)
      _(rebuilt.color).must_equal(pokemon.color)
      _(rebuilt.flavor_text_entries).must_equal(pokemon.flavor_text_entries)
      _(rebuilt.genera).must_equal(pokemon.genera)
      _(rebuilt.types).must_equal(pokemon.types)
      _(rebuilt.poke_likes).must_equal(pokemon.poke_likes)
      _(rebuilt.abilities.count).must_equal(pokemon.abilities.count)
      _(rebuilt.evochain.count).must_equal(pokemon.evochain.count)

      pokemon.abilities.each do |ability|
        found = rebuilt.abilities.find do |potential|
          potential.origin_id == ability.origin_id
        end

        _(found.ability_name).must_equal ability.ability_name
        _(found.flavor_text_entries).must_equal ability.flavor_text_entries
      end
    end
  end
end
