require './config/environment'

class RecipesController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/recipes' do
    if !is_logged_in
      redirect to '/login'
    else
      @user = current_user
      @recipes = Recipe.all
      erb :'recipes/index'
    end
  end

  get '/recipes/new' do
    if !is_logged_in
      redirect to '/login'
    else
      @user = current_user
      erb :'recipes/create_recipe'
    end
  end

  post '/recipes' do
    if !is_logged_in
      redirect to '/login'
    else
      @recipes = Recipe.create(user_id: current_user.id, content: params[:content])
      if @recipes.id.nil?
        redirect to '/recipes/new'
      else
        @user = current_user
        redirect to "/recipes/#{@recipes.id}"
      end
    end
  end

  get '/recipes/:id' do
    @recipes = []
    if !is_logged_in
      redirect to '/login'
    end
    @recipes.push(Recipe.find(params[:id]))
    if @recipes.empty?
      redirect to '/recipes'
    end
    @user = current_user
    erb :'recipes/index'
  end

  get '/recipes/:id/edit' do
    if !is_logged_in
      redirect to '/login'
    end
    @recipe = Recipe.find(params[:id])
    #redirect non-recipe owning users to /recipes
    if current_user.id != @recipe.user_id
      redirect to '/recipes'
    end
    erb :'recipes/edit_recipe'
  end

  patch '/recipes/:id' do
    if params[:content].empty?
      redirect to "/recipes/#{params[:id]}/edit"
    end
    @recipe = Recipe.find(params[:id])
    @recipe.update(content: params[:content])
    redirect to "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id/delete' do
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
