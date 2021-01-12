# frozen_string_literal: true

# Page object for home page
class HomePage
  include PageObject

  page_url MerciDanke::App.config.APP_HOST

  div(:warning_message, id: 'flash_bar_danger')
  div(:success_message, id: 'flash_bar_success')

  h1(:title_heading, id: 'main_header')
  text_field(:poke_name_input, id: 'pokemon_input')
  button(:add_products_button, id: 'products_form_submit')
  button(:advance_button, id: 'advance_button')
  a(:pokemon_link, id: 'pokemon[0].poke_link')
  # pokemons' cards
  indexed_property(
    :pokemons,
    [
      [:a, :pokemon_url, { id: 'pokemon.poke_link' }]
    ]
  )
  def first_pokemon
    pokemons[0]
  end

  def add_new_products(remote_poke_name)
    self.poke_name_input = remote_poke_name
    add_products_button
  end
end
