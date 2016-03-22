users = [{username: "Peter", email: "pb@totmail.com", password: "asdf"},
         {username: "Mike", email: "mb@aol.com", password: "asdf"},
         {username: "Greg", email: "gb@gmail.com", password: "asdf"},
         {username: "Bobby", email: "bb@microsoft.com", password: "asdf"},
         {username: "Carol", email: "carol@bradyservices.com", password: "asdf"},
         {username: "Jan", email: "jb@bradybunch.com", password: "asdf"},
         {username: "Cindy", email: "cindy@mac.com", password: "asdf"},
         {username: "Marsha", email: "m@bradys.com", password: "asdf"},
         {username: "Alice", email: "keepertoo@bradys.com", password: "asdf"}]

users.each do |params|
  User.create(params)
end
@peter = User.find_by(username: "Peter")
@bobby = User.find_by(username: "Bobby")
@greg = User.find_by(username: "Greg")
@cindy = User.find_by(username: "Cindy")
@marsha = User.find_by(username: "Marsha")
@jan= User.find_by(username: "Jan")
@carol = User.find_by(username: "Carol")
@alice = User.find_by(username: "Alice")
@mike = User.find_by(username: "Mike")

#array of recipe params
recipes = []
#array of recipe_ingredient params
recipe_ingredients = []
#array of simple ingredients
ingredients = ["Water", "Flour", "Sugar", "Yeast", "Baking Powder", "Salt", "Oil", "Eggs", "Butter", "Milk"]
ingredients.each do |ing|
  Ingredient.create(name: ing)
end
@water = Ingredient.find_by(name: "Water")
@flour = Ingredient.find_by(name: "Flour")
@sugar = Ingredient.find_by(name: "Sugar")
@yeast = Ingredient.find_by(name: "Yeast")
@powder = Ingredient.find_by(name: "Baking Powder")
@salt = Ingredient.find_by(name: "Salt")
@oil = Ingredient.find_by(name: "Oil")
@eggs = Ingredient.find_by(name: "Eggs")
@butter = Ingredient.find_by(name: "Butter")
@milk = Ingredient.find_by(name: "Milk")

# recipe_ingredients.push({recipe_id: , ingredient_id: , quantity_value: , quantity_unit: "", qualifier: ""})
ccc = Recipe.create({name: "Chocolate Chip Cookies", user_id: @peter.id, directions: "Mix ingredients, scoop onto pan, bake", prep_time_in_minutes: 30, cook_time_in_minutes: 14})
ccc.recipe_ingredients.build(recipe_id: ccc.id, ingredient_id:@flour.id, quantity_value: "2", quantity_unit: "cups", qualifier: "")
ccc.recipe_ingredients.build(recipe_id: ccc.id, ingredient_id:@milk.id, quantity_value: "1", quantity_unit: "cups", qualifier: "")
ccc.recipe_ingredients.build(recipe_id: ccc.id, ingredient_id:@butter.id, quantity_value: "1", quantity_unit: "cups", qualifier: "")
ccc.recipe_ingredients.build(recipe_id: ccc.id, ingredient_id:@sugar.id, quantity_value: "1", quantity_unit: "cups", qualifier: "")
ccc.recipe_ingredients.build(recipe_id: ccc.id, ingredient_id:@salt.id, quantity_value: "1", quantity_unit: "teaspoon", qualifier: "")
ccc.save

pizza = Recipe.create({name: "Pizza", user_id: @alice.id, directions: "Make the dough, spread it out, put the toppings on, bake", prep_time_in_minutes: 180, cook_time_in_minutes: 45})
pizza.recipe_ingredients.build(recipe_id: pizza.id, ingredient_id:@flour.id, quantity_value: "3", quantity_unit: "cups", qualifier: "")
pizza.recipe_ingredients.build(recipe_id: pizza.id, ingredient_id:@yeast.id, quantity_value: "1", quantity_unit: "cup", qualifier: "")
pizza.recipe_ingredients.build(recipe_id: pizza.id, ingredient_id:@oil.id, quantity_value: "1", quantity_unit: "Tablespoon", qualifier: "")
pizza.recipe_ingredients.build(recipe_id: pizza.id, ingredient_id:@salt.id, quantity_value: "1", quantity_unit: "teaspoon", qualifier: "")
pizza.save
