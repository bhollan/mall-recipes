class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.decimal :quantity_value
      t.string :quantity_unit
      t.string :qualifier
    end
  end
end
