# frozen_string_literal: true

require 'net/http'
require 'yaml'
require 'json'

def poke_api_path(type_id)
  'https://pokeapi.co/api/v2/type/' + type_id
end

# after call_poke_url we get the json object
def call_poke_url(url)
  JSON.parse(Net::HTTP.get(URI(url)))
end

type_results = {}

url = poke_api_path('1')
poke_obj = call_poke_url(url)

type_results['damage_relations'] = poke_obj['damage_relations']
type_results['name'] = poke_obj['name']
type_results['pokemon'] = poke_obj['pokemon'].map { |num| num['pokemon']['name'] }

# put the type's name, flavor_text_entries, pokemons' names into the yaml file
File.write('spec/fixtures/poke_data/type_results.yml', type_results.to_yaml)
