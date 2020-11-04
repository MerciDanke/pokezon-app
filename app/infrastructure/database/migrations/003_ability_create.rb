# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:ability) do
      primary_key :ability_name
      foreign_key :abilities, :pokemon

      String      :flavor_text_entries
      Array       :ability_pokemons

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
