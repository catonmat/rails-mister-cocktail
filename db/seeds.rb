# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "JSON"
# require "pry-byebug"

# Full API: https://forum.kodi.tv/showthread.php?tid=235298

# Cocktails API
def validator(hash_value)
  case hash_value
  when nil
    false
  when ''
    false
  when ' '
    false
  when "\n"
    false
  else
    true
  end
end

def call_api
  cocktail_url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktail_doc = URI.open(cocktail_url).read
  cocktail_api = JSON.parse(cocktail_doc)
  cocktail_api["drinks"][0]
end

def create_dose_ingredient_hash(cocktail_data)
  cocktail_ingredients = cocktail_data.select { |k, v| k.match("strIngredient") && validator(v) }.values
  cocktail_doses = cocktail_data.select { |k, v| k.match("strMeasure") && validator(v) }.values
  Hash[cocktail_ingredients.zip(cocktail_doses)]
end

100.times do
  cocktail_data = call_api
  cocktail_name = cocktail_data["strDrink"]
  cocktail_hash = create_dose_ingredient_hash(cocktail_data)
  image_url = cocktail_data["strDrinkThumb"]

  new_cocktail = Cocktail.find_or_create_by(name: cocktail_name, image: image_url)

  cocktail_hash.each do |ingredient, dose|
    new_ingredient = Ingredient.find_or_create_by(name: ingredient)
    new_dose = Dose.new(description: dose)
    new_dose.ingredient = new_ingredient
    new_dose.cocktail = new_cocktail
    new_dose.save
  end
end

# # Ingredients API (Redundant: Was used to generate comprehensive list of ingredients)
# ingredient_url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# ingredient_doc = URI.open(ingredient_url).read
# ingredient_api = JSON.parse(ingredient_doc)
# ingredient = ingredient_api["drinks"]

# ingredients_array = []

# ingredient.each do |ingredient|
#   ingredients_array << ingredient["strIngredient1"]
# end




# # Redundant
# def create_ingredients(cocktail_data)
#   cocktail_ingredients = cocktail_data.select { |k, v| k.match("strIngredient") && (v != '') }.values
#   cocktail_ingredients.each { |ingredient| Ingredient.create(ingredient) }
# end

# def create_doses(cocktail_data)
#   cocktail_doses = cocktail_data.select { |k, v| k.match("strMeasure") && (v != '' && v.size > 1) }.values
#   cocktail_doses.each { |dose| Dose.create(description: dose, ingredient_id: ingredient) }
# end



# # Redundant
# def create_first_cocktail
#   cocktail_data = call_api
#   cocktail_name = cocktail_data["strDrink"]
#   cocktail_hash = create_dose_ingredient_hash(cocktail_data)

#   new_cocktail = Cocktail.create(name: cocktail_name)

#   cocktail_hash.each do |ingredient, dose|
#     new_ingredient = Ingredient.create(name: ingredient)
#     new_dose = Dose.create(description: dose)
#     new_dose.ingredient_id = new_ingredient.id
#     new_dose.cocktail_id = new_cocktail.id
#     new_dose.save!
#   end

# end

# create_first_cocktail #Optional Method











