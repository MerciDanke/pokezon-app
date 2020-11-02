# frozen_string_literal: true

require 'http'
require 'yaml'
require 'json'

def amazon_api_path(config, poke_name)
  "https://api.zilerate.com/amazon/category?apiKey=#{config['API_KEY']}&url=https%3A%2F%2Fwww.amazon.com%2Fs%3Fk%3D#{poke_name}"
end

# after call_amazon_url we get the json object
def call_amazon_url(url)
  JSON.parse(
    HTTP
      .get(URI(url))
  )
end

config = YAML.safe_load(File.read('config/secrets.yml'))
url = amazon_api_path(config, 'Pikachu')
amazon_obj = call_amazon_url(url)
<<<<<<< HEAD
# product_index = 1
# amazon_results = {}
# amazon_obj['results'].map do |element|
#   amazon_results[product_index] = element
#   product_index += 1
# end

# REsults jijiji
=======

# store attr in class Results
>>>>>>> 6f638ce8e1bc9e629ca0452bb9933a0a1d56931e
class Results
  attr_reader :title, :link, :image, :rating, :ratings_total, :currency, :price

  # def initialize(title, link, image, rating, ratings_total, currency, price)
  def initialize(title, link, image, rating, ratings_total, currency, price)
    @title = title
    @link = link
    @image = image
    @rating = rating
    @ratings_total = ratings_total
    @currency = currency
    @price = price
  end
end

amazon_results = amazon_obj['results'].map do |res|
  # puts res['prices'][0]['price']
  Results.new(res['title'], res['link'], res['image'], res['rating'], res['ratingsTotal'], res['prices'][0]['currency'], res['prices'][0]['price'])
  # , res['image'], res['rating'], res['ratingsTotal'], res['prices'][0]['currency'], res['prices'][0]['rawPrice']
end

# put the product results into the yaml file
File.write('spec/fixtures/amazon_data/amazon_results.yml', amazon_results.to_yaml)
