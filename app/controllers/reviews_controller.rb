require './config/environment'

class ReviewsController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/recipes/:id/review/create/?' do
    if !is_logged_in
      session[:error] = "You must be logged in to perform this action."
      redirect to '/login'
    else
      @recipe = Recipe.find(params[:id])
      erb :'/reviews/create_review'
    end
  end

  post '/review/create'do
    if !is_logged_in
      session[:error] = "You must be logged in to perform this action."
      redirect to '/login'
    else
      new_review = Review.find_or_create_by(user_id: params[:user_id], recipe_id: params[:recipe_id])
      new_review.update(stars: params[:stars], text: params[:text])
      redirect to "/recipes/#{params[:recipe_id]}"
    end
  end

  get '/reviews/mine/?' do
    if !is_logged_in
      session[:error] = "You must be logged in to perform this action."
      redirect to '/login'
    else
      @reviews = Review.where(user_id: current_user.id)
      erb :'/reviews/index'
    end
  end

  delete '/review/:id/delete' do
    if !is_logged_in
      session[:error] = "You must be logged in to perform this action."
      redirect to '/login'
    else
      @review = Review.find(params[:id])
      if current_user.id != @review.user_id
        session[:error] = "You can only delete your own recipes."
        redirect to '/recipes'
      else
        @review.delete
        session[:notice] = "Successfully deleted recipe."
        redirect to '/recipes'
      end
    end
  end

end
