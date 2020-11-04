# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:pokemon) do
      primary_key :poke_name

      Integer     :id, unique: true
      String      :type, unique: true
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
      Array       :abilities

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
