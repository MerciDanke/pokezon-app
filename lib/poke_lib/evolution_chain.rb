# frozen_string_literal: false

module EvolutionChainInf
  # Model for EvolutionChain
  class EvolutionChain
    def initialize(evolution_chain_data)
      @evolution_chain = evolution_chain_data
    end

    def name
      @evolution_chain['chain']['species']['name']
    end

    def evolutions_to
      @evolution_chain['chain']['evolves_to'][0]['species']['name']
    end

    def evolutions_to_second
      ev_second = @evolution_chain['chain']['evolves_to'][0]['evolves_to']
      ev_second[0].nil? ? nil : ['species']['name']
      # ev_second[0].nil? ? nil : ev_second[0]['species']['name']
    end
  end
end
