# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:product) do
      primary_key :id
      foreign_key :poke_name, :pokemon

      String      :title, unique: true
      String      :link, unique: true
      String      :image
      Float       :rating
      Integer     :ratings_total
      Float       :price
      String      :currency

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
