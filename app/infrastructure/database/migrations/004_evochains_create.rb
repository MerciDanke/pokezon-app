# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:evochains) do
      primary_key :id

      Integer     :origin_id, unique: true
      String      :chain_species_name
      String      :evolves_to
      String      :evolves_to_second

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
