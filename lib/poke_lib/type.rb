# frozen_string_literal: false

module TypeInf
  # Model for Type
  class Type
    def initialize(type_data)
      @type = type_data
    end

    def name
      @type['name']
    end

    def pokemon
      @type['pokemon'].map { |num| num['pokemon']['name'] }
    end

    def double_damage_from
      ddf = @type['damage_relations']['double_damage_from']
      ddf[0].nil? ? nil : ddf.map { |num| num['name'] }
    end

    def double_damage_to
      ddto = @type['damage_relations']['double_damage_to']
      ddto[0].nil? ? nil : ddto.map { |num| num['name'] }
    end

    def half_damage_from
      hdf = @type['damage_relations']['half_damage_from']
      hdf[0].nil? ? nil : hdf.map { |num| num['name'] }
    end

    def half_damage_to
      hdto = @type['damage_relations']['half_damage_to']
      hdto[0].nil? ? nil : hdto.map { |num| num['name'] }
    end

    def no_damage_from
      ndf = @type['damage_relations']['no_damage_from']
      ndf[0].nil? ? nil : ndf.map { |num| num['name'] }
    end

    def no_damage_to
      ndto = @type['damage_relations']['no_damage_to']
      ndto[0].nil? ? nil : ndto.map { |num| num['name'] }
    end
  end
end
