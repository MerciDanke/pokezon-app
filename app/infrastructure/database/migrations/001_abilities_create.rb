# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:abilities) do
      primary_key :id

      Integer     :origin_id, unique: true
      String      :ability_name
      String      :flavor_text_entries
      String      :ability_pokemons

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
