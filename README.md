# Shopping with Pokémon
Currently, there are more than 800 types of Pokemon.
We list all Pokémon’s information(attributes, features, abilities, etc). Besides, we will also list related products(based on price and rating) that sells on Amazon. For example, if you are browsing Pikachu's information, you can also see the products of Pikachu in the same page.
## Our features(Domain value)
Problems to be solved:
While understanding the characteristics of different Pokémon, explore different products, and can search for Pokémon or products according to personal needs.
- You can search for Pokémon according to type, color, habitat, height, weight
- You can filter products based on the price and rating of the product
## Language of the Domain
original JSON description -> **our YAML description**

Pokémon
- id -> **id**
- name -> **name**
- abilities/ability -> **abilities**
- height(m) -> **height**
- weight(kg) -> **weight**
- types -> **types**
- forms-url -> **back_default** ; **back_shiny** ; **front_default** ; **front_shiny**
- speices-url -> **color** ; **flavor_text_entries** ; **genera** ; **habitat**

Amazon products
- results -> **product<index>**
- title -> **title**
- link -> **link**
- image -> **image**
- rating -> **rating**
- ratingTotal -> **ratingTotal**
- prices/currency -> **prices/currency**
- prices/price -> **prices/price**

## Short-term usability goals
- Pull data from Amazon API and Pokemon API
- Classify Pokemon data by type, color, habitat, height and weight
- Map different type, color, habitat, height and weight of pokemons to products
- Filter the products by different conditions
- Display Pokemon details with related products at the same time

## Long-term goals
- Perform static analysis of folders/files: e.g., flog, rubocop, reek for Ruby