# frozen_string_literal: true

require 'net/http'
require 'yaml'
require 'json'

def poke_api_path(ability_id)
  "https://pokeapi.co/api/v2/ability/#{ability_id}"
end

# after call_poke_url we get the json object
def call_poke_url(url)
  JSON.parse(Net::HTTP.get(URI(url)))
end

ability_results = {}

url = poke_api_path('1')
poke_obj = call_poke_url(url)

# flavor_text_entries has language's order problem
ability_results['flavor_text_entries'] = poke_obj['flavor_text_entries'][0]['flavor_text']
ability_results['name'] = poke_obj['name']
ability_results['pokemon'] = poke_obj['pokemon'].map { |num| num['pokemon']['name'] }

# put the ability's name, flavor_text_entries, pokemons' names into the yaml file
File.write('spec/fixtures/poke_data/ability_results.yml', ability_results.to_yaml)
