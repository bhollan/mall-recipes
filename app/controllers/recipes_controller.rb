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
      session[:error] = "You must be logged in to perform this action."
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
      session[:error] = "You must be logged in to perform this action."
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
    #this is the actual creat_recipe form
    if !is_logged_in
      session[:error] = "You must be logged in to perform this action."
      redirect to '/login'
    elsif params[:recipe][:directions].empty? || params[:recipe][:name].empty?
      #user did not populate a required field
      session[:error] = "Recipes must have a 'name' and 'directions'."
      redirect to "/recipes/?"
    else
      #find the recipe
      @recipe = Recipe.create(params[:recipe])
      if @recipe.nil? || @recipe.id.nil?
        session[:error] = "Something went wrong in recipe creation."
        redirect to '/recipes/new'
      else
        #assign current user
        @recipe.update(user_id: current_user.id)
        if !params[:new_ingredient][:name].empty?
          #create new ingredient from field
          new_ing = Ingredient.find_or_create_by(name: params[:new_ingredient][:name])
          params[:new_recipe_ingredient][:ingredient_id] = new_ing.id
          if params[:recipe_ingredients].nil?
            params[:recipe_ingredients] = []
          end
          params[:recipe_ingredients].push(params[:new_recipe_ingredient])
        end
        if !params[:recipe_ingredients].nil?
          #only build association if there are ingredients
          params[:recipe_ingredients].each do |entry|
            if !entry.nil?
              @recipe.recipe_ingredients.build(entry)
            end
          end
        end
        @recipe.save
        redirect to "/recipes/#{@recipe.id}"
      end
    end
  end

  get '/recipes/mine/?' do
    if !is_logged_in
      session[:error] = "You must be logged in to perform this action."
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
    @reviews = Review.where(recipe_id: @recipe.id)
    erb :'recipes/show_recipe'
  end

  get '/recipes/:id/edit/?' do
    if !is_logged_in
      session[:error] = "You must be logged in to perform this action."
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
      #user cleared a required field
      session[:error] = "Recipes must have a 'name' and 'directions'."
      redirect to "/recipes/#{params[:id]}/edit"
    end
    #find :id's recipe
    @recipe = Recipe.find(params[:id])
    #this will have to change
    @recipe.update(params[:recipe])
    if !params[:recipe_ingredient_ids].empty?
      #only do this with there are ingredients
      params[:recipe_ingredient_ids].each_with_index do |entry_id_hash, i|
        #find the entry, knowing the index
        entry = RecipeIngredient.find_by(entry_id_hash)
        if params[:recipe_ingredients][i][:ingredient_id]=="0"
          #delete if marked by user to delete this entry
          entry.delete
        else
          #otherwise, update it with the new info
          entry.update(params[:recipe_ingredients][i])
        end
      end
    end
    if !params[:new_ingredient][:name].empty?
      #deal with new ingredient if present
      new_ing = Ingredient.find_or_create_by(name: params[:new_ingredient][:name])
      params[:new_recipe_ingredient][:ingredient_id] = new_ing.id
      @recipe.recipe_ingredients.build(params[:new_recipe_ingredient])
    end
    @recipe.save
    session[:notice] = "Successfully updated recipe."
    redirect to "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id/delete/?' do
    if !is_logged_in
      #user is not logged in
      session[:error] = "You must be logged in to perform this action."
      redirect to '/login'
    end
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id != current_user.id
      #current user is not recipe's author
      session[:error] = "You can only delete your own recipes."
      redirect to '/recipes'
    end
    @recipe.recipe_ingredients.each do |entry|
      #we must delete all recipe_ingredient entries
      entry.delete
      #if we don't, listing recipes by ingredient will fail
    end
    @recipe.destroy
    session[:notice] = "Recipe successfully deleted."
    redirect to '/recipes'
  end

end
