# frozen_string_literal: true

# merge into get_pokemon_api.rb
require 'net/http'
require 'yaml'
require 'json'

def poke_api_path(pokespe_id)
  "https://pokeapi.co/api/v2/pokemon-species/#{pokespe_id}"
end

# after call_poke_url we get the json object
def call_poke_url(url)
  JSON.parse(Net::HTTP.get(URI(url)))
end

poke_results = {}

url = poke_api_path('1')
poke_obj = call_poke_url(url)

# flavor_text_entries & genera have language's order problem
poke_results['id'] = poke_obj['id']
poke_results['name'] = poke_obj['name']
poke_results['habitat'] = poke_obj['habitat']['name']
poke_results['color'] = poke_obj['color']['name']
poke_results['flavor_text_entries'] = poke_obj['flavor_text_entries'][0]['flavor_text']
poke_results['genera'] = poke_obj['genera'][7]['genus']

# put the pokemon_species1's color, flavor_text_entries, genera into the yaml file
File.write('spec/fixtures/poke_data/poke_spec1_results.yml', poke_results.to_yaml)
