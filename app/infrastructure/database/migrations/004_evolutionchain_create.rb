# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:evolutionchain) do
      primary_key :chain_species_name
      foreign_key :poke_name, :pokemon

      String      :evolves_to
      String      :evolves_to_second

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
