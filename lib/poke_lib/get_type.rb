# frozen_string_literal: true

require 'http'
require 'yaml'
require 'json'

def poke_api_path(type_id)
  "https://pokeapi.co/api/v2/type/#{type_id}"
end

# after call_poke_url we get the json object
def call_poke_url(url)
  JSON.parse(
    HTTP
    .get(URI(url))
  )
end

type_results = {}

url = poke_api_path('1')
poke_obj = call_poke_url(url)

ddf = poke_obj['damage_relations']['double_damage_from']
ddto = poke_obj['damage_relations']['double_damage_to']
hdf = poke_obj['damage_relations']['half_damage_from']
hdto = poke_obj['damage_relations']['half_damage_to']
ndf = poke_obj['damage_relations']['no_damage_from']
ndto = poke_obj['damage_relations']['no_damage_to']
type_results['double_damage_from'] = ddf.map { |num| num['name'] } if ddf[0]
type_results['double_damage_to'] = ddto.map { |num| num['name'] } if ddto[0]
type_results['half_damage_from'] = hdf.map { |num| num['name'] } if hdf[0]
type_results['half_damage_to'] = hdto.map { |num| num['name'] } if hdto[0]
type_results['no_damage_from'] = ndf.map { |num| num['name'] } if ndf[0]
type_results['no_damage_to'] = ndto.map { |num| num['name'] } if ndto[0]
# type_results['double_damage_from'] = ddf[0].nil? ? nil : ddf.map { |num| num['name'] }
# type_results['double_damage_to'] = ddto[0].nil? ? nil : ddto.map { |num| num['name'] }
# type_results['half_damage_from'] = hdf[0].nil? ? nil : hdf.map { |num| num['name'] }
# type_results['half_damage_to'] = hdto[0].nil? ? nil : hdto.map { |num| num['name'] }
# type_results['no_damage_from'] = ndf[0].nil? ? nil : ndf.map { |num| num['name'] }
# type_results['no_damage_to'] = ndto[0].nil? ? nil : ndto.map { |num| num['name'] }
type_results['name'] = poke_obj['name']
type_results['pokemon'] = poke_obj['pokemon'].map { |num| num['pokemon']['name'] }

# put the type's name, flavor_text_entries, pokemons' names into the yaml file
File.write('spec/fixtures/poke_data/type_results.yml', type_results.to_yaml)
