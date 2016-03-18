require './config/environment'

class ReviewsController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end
  #
  # get '/reviews' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   else
  #     @user = current_user
  #     @reviews = Review.all
  #     erb :'reviews/index'
  #   end
  # end
  #
  # get '/reviews/new' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   else
  #     @user = current_user
  #     erb :'reviews/create_review'
  #   end
  # end
  #
  # post '/reviews' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   else
  #     @reviews = Review.create(user_id: current_user.id, content: params[:content])
  #     if @reviews.id.nil?
  #       redirect to '/reviews/new'
  #     else
  #       @user = current_user
  #       redirect to "/reviews/#{@reviews.id}"
  #     end
  #   end
  # end
  #
  # get '/reviews/:id' do
  #   @reviews = []
  #   if !is_logged_in
  #     redirect to '/login'
  #   end
  #   @reviews.push(Review.find(params[:id]))
  #   if @reviews.empty?
  #     redirect to '/reviews'
  #   end
  #   @user = current_user
  #   erb :'reviews/index'
  # end
  #
  # get '/reviews/:id/edit' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   end
  #   @review = Review.find(params[:id])
  #   #redirect non-review owning users to /reviews
  #   if current_user.id != @review.user_id
  #     redirect to '/reviews'
  #   end
  #   erb :'reviews/edit_review'
  # end
  #
  # patch '/reviews/:id' do
  #   if params[:content].empty?
  #     redirect to "/reviews/#{params[:id]}/edit"
  #   end
  #   @review = Review.find(params[:id])
  #   @review.update(content: params[:content])
  #   redirect to "/reviews/#{params[:id]}"
  # end
  #
  # delete '/reviews/:id/delete' do
  #   if !is_logged_in
  #     redirect to '/login'
  #   end
  #   @review = Review.find(params[:id])
  #   if @review.user_id != current_user.id
  #     redirect to '/reviews'
  #   end
  #   @review.destroy
  #   redirect to '/reviews'
  # end
  #
end
