# Shopping with Pokémon
Currently, there are more than 800 types of Pokémon.
We list all Pokémon’s information(attributes, features, abilities, etc). Besides, we will also list related products(based on price and rating) that sells on Google Shopping. For example, if you are browsing Pikachu's information, you can also see the products of Pikachu in the same page.
## Our features(Domain value)
Problems to be solved:
While understanding the characteristics of different Pokémon, explore different products, and can search for Pokémon or products according to personal needs.
- You can search Pokémon according to type, color, habitat, height, weight.
- You can sort products based on the price, rating or likes of the products.
- You can see the popularity of each Pokémon based on likes, rating & product num.
## Language of the Domain
Original JSON description -> **Our YAML description**

Pokémon
- id -> **id**
- name -> **name**
- abilities/ability -> **abilities**
- height(m) -> **height**
- weight(kg) -> **weight**
- types -> **types**
- forms-url -> **back_default** ; **back_shiny** ; **front_default** ; **front_shiny**
- speices-url -> **color** ; **flavor_text_entries** ; **genera** ; **habitat**
- evolution-chain -> **evolves_to** ; **evolves_to_second**

Google Shopping products
- results -> **product<index>**
- title -> **title**
- link -> **link**
- image -> **thumbnail**
- rating -> **rating**
- ratingTotal -> **reviews**
- prices/currency -> **price**

## Short-term usability goals
- Pull data from Google Shopping API and Pokémon API
- Classify Pokémon data by type, color, habitat, height and weight
- Map different type, color, habitat, height and weight of pokémon to products
- Search the products by different conditions
- Display Pokémon details with related products at the same time

## Long-term goals
- Perform static analysis of folders/files: e.g., flog, rubocop, reek for Ruby

![image](https://github.com/MerciDanke/pokezon-app/blob/master/product_page.PNG)