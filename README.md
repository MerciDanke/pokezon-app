# Shopping with Pokémon
Currently, there are more than 800 types of Pokemon.
We list all Pokémon’s information(attributes, features, abilities, etc). Besides, we will also list related products(based on price and rating) that sells on Amazon. For example, if you are browsing Pikachu's information, you can also see the products of Pikachu in the same page.
## Language of the Domain
original JSON description -> **our YAML description**
Pokemon
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
- prices/rawPrice -> **prices/rawPrice**