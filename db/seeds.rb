users = [{username: "Peter", email: "pb@totmail.com", password: "asdf"},
         {username: "Mike", email: "mb@aol.com", password: "asdf"},
         {username: "Greg", email: "gb@gmail.com", password: "asdf"},
         {username: "Bobby", email: "bb@microsoft.com", password: "asdf"},
         {username: "Carol", email: "carol@bradyservices.com", password: "asdf"},
         {username: "Jan", email: "jb@bradybunch.com", password: "asdf"},
         {username: "Cindy", email: "cindy@mac.com", password: "asdf"}]

users.each do |params|
  User.create(params)
end

#array of recipe params
recipes = []
#array of recipe_ingredient params
recipe_ingredients = []
#array of simple ingredients for speed
ingredients = ["Water", "Flour", "Sugar", "Yeast", "Baking Powder", "Salt", "Oil", "Eggs", "Butter"]
ingredients.each do |ing|
  Ingredient.create(name: ing)
end

# recipes.push({name: "", user_id: , directions: "", prep_time_in_minutes: , cook_time_in_minutes: })
# recipe_ingredients.push({recipe_id: , ingredient_id: , quantity_value: , quantity_unit: "", qualifier: ""})
recipes.push({name: "Chocolate Chip Cookies", user_id: 1, directions: "Mix ingredients, scoop onto pan, bake", prep_time_in_minutes: 30, cook_time_in_minutes: 14})
recipe_ingredients.push({recipe_id: 1, ingredient_id:2, quantity_value: 1, quantity_unit: "cups"})
recipe_ingredients.push({recipe_id: 1, ingredient_id:1, quantity_value: 1, quantity_unit: "cups"})
recipe_ingredients.push({recipe_id: 1, ingredient_id:9, quantity_value: 1, quantity_unit: "cups", qualifier: "chilled"})


recipes.push({name: "Pizza", user_id: 2, directions: "Make the dough, spread it out, put the toppings on, bake", prep_time_in_minutes: 180, cook_time_in_minutes: 45})
recipe_ingredients.push({recipe_id: 2, ingredient_id:2, quantity_value: 3, quantity_unit: "cups"})
recipe_ingredients.push({recipe_id: 2, ingredient_id:1, quantity_value: 2, quantity_unit: "cups"})

recipes.each do |recipe|
  Recipe.create(recipe)
end

recipe_ingredients.each do |entry|
  RecipeIngredient.create(entry)
end
