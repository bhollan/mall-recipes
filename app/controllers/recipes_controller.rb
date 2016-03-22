require './config/environment'

class RecipesController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/recipes/?' do
    #list of all recipes ever
    @recipes = Recipe.all
    erb :'recipes/index'
  end

  get '/recipes/new/?' do
    #start recipe creation process
    if !is_logged_in
      redirect to '/login/?'
    else
      @user = current_user
      erb :'recipes/pre_create_recipe'
    end
  end

  post '/recipes/new/?' do
    #This is probably not best practice, but hey...
    #
    #recieve back num_of_ingredients and
    #display proper recipe creation form
    if !is_logged_in
      redirect to '/login'
    else
      if params[:num_of_ingredients]==""
        @ingredients = 3
      else
        @ingredients = params[:num_of_ingredients]
      end
      @user = current_user
      erb :'recipes/create_recipe'
    end
  end

  post '/recipes/?' do
    if !is_logged_in
      redirect to '/login'
    else
      @recipe = Recipe.create(params[:recipe])
      if @recipe.id.nil?
        redirect to '/recipes/new'
      else
        @recipe.update(user_id: current_user.id)
        if !params[:new_ingredient][:name].empty?
          new_ing = Ingredient.find_or_create_by(name: params[:new_ingredient][:name])
          params[:new_recipe_ingredient][:ingredient_id] = new_ing.id
          params[:recipe_ingredients].push(params[:new_recipe_ingredient])
        end
        @recipe.recipe_ingredients.build(params[:recipe_ingredients])
        @recipe.save
        redirect to "/recipes/#{@recipe.id}"
      end
    end
  end

  get '/recipes/mine/?' do
    if !is_logged_in
      redirect to '/login'
    else
      @user = current_user
      @recipes = Recipe.where(user_id: @user.id)
      erb :'recipes/index'
    end
  end

  get '/recipes/:id/?' do
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.nil?
      @recipes = Recipe.all
      redirect to '/recipes'
    end
    erb :'recipes/show_recipe'
  end

  get '/recipes/:id/edit/?' do
    if !is_logged_in
      redirect to '/login'
    end
    @recipe = Recipe.find(params[:id])
    if current_user.id != @recipe.user_id
      redirect to '/recipes'
    end
    @recipe_ingredients = RecipeIngredient.where(recipe_id: @recipe.id)
    erb :'recipes/edit_recipe'
  end

  patch '/recipes/:id/?' do
    if params[:recipe][:directions].empty? || params[:recipe][:name].empty?
      redirect to "/recipes/#{params[:id]}/edit"
    end
    @recipe = Recipe.find(params[:id])
    @recipe.update(params[:recipe])
    # if !params[:new_ingredient][:name].empty?
    #   new_ing = Ingredient.find_or_create_by(name: params[:new_ingredient][:name])
    #   params[:new_recipe_ingredient][:ingredient_id] = new_ing.id
    #   @recipe.recipe_ingredients.build(params[:recipe_ingredients])
    #   # params[:recipe_ingredients].push(params[:new_recipe_ingredient])
    # end
    # @recipe.save
    redirect to "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id/delete/?' do
    if !is_logged_in
      redirect to '/login'
    end
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id != current_user.id
      redirect to '/recipes'
    end
    @recipe.destroy
    redirect to '/recipes'
  end

end
