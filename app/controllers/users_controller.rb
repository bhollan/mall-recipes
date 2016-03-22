require './config/environment'

class UsersController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/signup/?' do
    if is_logged_in
      session[:error] = "You must be logged in to perform this action."
      redirect to '/recipes'
    else
      erb :'users/create_user'
    end
  end

  post '/signup/?' do
    begin
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    rescue
      session[:error] = "Username and/or email not unique."
      redirect to '/signup'
    end
    if @user.nil? || @user.id.nil?
      session[:error] = "Something went wrong in account creation."
      redirect to '/signup'
    else
      session[:id] = @user.id
      session[:notice] = "User #{@user.username} created and logged in."
      redirect to '/recipes', notice: 'New user successfully created'
    end
  end

  get '/login/?' do
    if is_logged_in
      session[:notice] = "You are already logged in."
      redirect to '/recipes'
    else
      erb :'users/login'
    end
  end

  post '/login/?' do
    @user = User.find_by(username: params[:username])
    if !@user
      session[:error] = "You must be logged in to perform this action."
      redirect to '/login'
    end
    @user.authenticate(params[:password])
    session[:id] = @user.id
    redirect to '/recipes'
  end

  get '/logout/?' do
    session.clear
    session[:notice] = "You have been logged out."
    redirect to '/recipes'
  end

  get '/users/?' do
    @users = User.all
    erb :'/users/index'
  end

  get '/users/:id/?' do
    @user = User.find(params[:id])
    if !@user
      session[:error] = "There was an error recovering that account."
      redirect to '/users'
    else
      @recipes = Recipe.where(user_id: @user.id)
      erb :'/recipes/index'
    end
  end

end
