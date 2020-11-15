# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:types) do
      primary_key :id

      String      :type_name

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
