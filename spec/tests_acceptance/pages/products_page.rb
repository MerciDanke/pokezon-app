# frozen_string_literal: true

# Page object for producdts page
class ProductsPage
  include PageObject

  page_url MerciDanke::App.config.APP_HOST + '/products/bulbasaur'

  div(:warning_message, id: 'flash_bar_danger')
  div(:success_message, id: 'flash_bar_success')

  h1(:products_title, id: 'products_name')
  table(:pokemon_intro, id: 'intro_table')
  ul(:pokemon_details, id: 'tablist')

  # products' cards
  indexed_property(
    :products,
    [
      [:a,   :product_link, { id: 'product[%s].link' }],
      [:img, :product_rating, { id: 'product[%s].rating' }]
    ]
  )
end
