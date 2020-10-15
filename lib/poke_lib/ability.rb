# frozen_string_literal: false

module AbilityInf
  # Model for Ability
  class Ability
    def initialize(ability_data)
      @ability = ability_data
    end

    def name
      @ability['name']
    end

    def pokemon
      @ability['pokemon'].map { |num| num['pokemon']['name'] }
    end

    def flavor_text_entries
      @ability['flavor_text_entries'][0]['flavor_text']
    end
  end
end
