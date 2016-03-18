require './config/environment'

class IngredientsController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end
  #
  # get '/ingredients' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   else
  #     @user = current_user
  #     @ingredients = Ingredient.all
  #     erb :'ingredients/index'
  #   end
  # end
  #
  # get '/ingredients/new' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   else
  #     @user = current_user
  #     erb :'ingredients/create_ingredient'
  #   end
  # end
  #
  # post '/ingredients' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   else
  #     @ingredients = Ingredient.create(user_id: current_user.id, content: params[:content])
  #     if @ingredients.id.nil?
  #       redirect to '/ingredients/new'
  #     else
  #       @user = current_user
  #       redirect to "/ingredients/#{@ingredients.id}"
  #     end
  #   end
  # end
  #
  # get '/ingredients/:id' do
  #   @ingredients = []
  #   if !is_logged_in
  #     redirect to '/login'
  #   end
  #   @ingredients.push(Ingredient.find(params[:id]))
  #   if @ingredients.empty?
  #     redirect to '/ingredients'
  #   end
  #   @user = current_user
  #   erb :'ingredients/index'
  # end
  #
  # get '/ingredients/:id/edit' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   end
  #   @ingredient = Ingredient.find(params[:id])
  #   #redirect non-ingredient owning users to /ingredients
  #   if current_user.id != @ingredient.user_id
  #     redirect to '/ingredients'
  #   end
  #   erb :'ingredients/edit_ingredient'
  # end
  #
  # patch '/ingredients/:id' do
  #   if params[:content].empty?
  #     redirect to "/ingredients/#{params[:id]}/edit"
  #   end
  #   @ingredient = Ingredient.find(params[:id])
  #   @ingredient.update(content: params[:content])
  #   redirect to "/ingredients/#{params[:id]}"
  # end
  #
  # delete '/ingredients/:id/delete' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   end
  #   @ingredient = Ingredient.find(params[:id])
  #   if @ingredient.user_id != current_user.id
  #     redirect to '/ingredients'
  #   end
  #   @ingredient.destroy
  #   redirect to '/ingredients'
  # end
  #
end
