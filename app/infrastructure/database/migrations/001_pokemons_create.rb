# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:pokemons) do
      primary_key :id
      foreign_key :ability_id, :abilities
      foreign_key :evochain_id, :evochains

      Integer     :origin_id, unique: true
      String      :poke_name
      String      :type
      Integer     :height
      Integer     :weight
      String      :back_default
      String      :back_shiny
      String      :front_default
      String      :front_shiny
      String      :habitat
      String      :color
      String      :flavor_text_entries
      String      :genera
      # Array       :abilities

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
