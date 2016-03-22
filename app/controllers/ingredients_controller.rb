require './config/environment'

class IngredientsController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/ingredients' do
    erb :'/ingredients/index'
  end

  post '/ingredients' do
    recipe_ids = RecipeIngredient.where(ingredient_id: params[:ingredient_id]).collect{|entry| entry.recipe_id}
    if params[:selection]=="without"
      all_recipe_ids = Recipe.all.map{|recipe| recipe.id}
      recipe_ids = all_recipe_ids - recipe_ids
    end
    @recipes = recipe_ids.map{|id| Recipe.find(id)}.uniq
    erb :'/recipes/index'
  end
end
