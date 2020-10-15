# frozen_string_literal: true

require 'net/http'
require 'yaml'
require 'json'

def poke_api_path(poke_id)
  'https://pokeapi.co/api/v2/pokemon/' + poke_id
end

# after call_poke_url we get the json object
def call_poke_url(url)
  JSON.parse(Net::HTTP.get(URI(url)))
end

poke_results = {}

url = poke_api_path('1')
poke_obj = call_poke_url(url)

poke_results['id'] = poke_obj['id']
poke_results['name'] = poke_obj['name']
poke_results['type'] = poke_obj['types'].map { |num| num['type']['name'] }
poke_results['abilities'] = poke_obj['abilities'].map { |num| num['ability']['name'] }
poke_results['height'] = poke_obj['height']
poke_results['weight'] = poke_obj['weight']

forms_url = poke_obj['forms'][0]['url']
forms_obj = call_poke_url(forms_url)
poke_results['back_default'] = forms_obj['sprites']['back_default']
poke_results['back_shiny'] = forms_obj['sprites']['back_shiny']
poke_results['front_default'] = forms_obj['sprites']['front_default']
poke_results['front_shiny'] = forms_obj['sprites']['front_shiny']

# put the pokemon1's abilities, height, weight into the yaml file
File.write('spec/fixtures/poke_data/poke1_results.yml', poke_results.to_yaml)
