# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'type_representer'
require_relative 'ability_representer'
require_relative 'evochain_representer'

module MerciDanke
  module Representer
    # Represents about pokemons
    class Pokemon < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :id
      property :origin_id
      property :poke_name
      collection :types, extend: Representer::Type, class: OpenStruct
      property :height
      property :weight
      property :back_default
      property :back_shiny
      property :front_default
      property :front_shiny
      property :habitat
      property :color
      property :flavor_text_entries
      property :genera
      # Evochain
      property :evochain, extend: Representer::Evochain, class: OpenStruct
      # Ability
      collection :abilities, extend: Representer::Ability, class: OpenStruct
      property :poke_likes

      link :self do
        "#{App.config.API_HOST}/api/v1/pokemon/#{poke_name}"
      end

      private

      def poke_id
        represented.origin_id
      end
    end
  end
end
