require './config/environment'

class UsersController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/signup' do
    if is_logged_in
      redirect to '/recipes'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.id.nil?
      redirect to '/signup'
    else
      session[:id] = @user.id
      redirect to '/recipes', notice: 'New user successfully created'
    end
  end

  get '/login' do
    if is_logged_in
      redirect to '/recipes'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !@user
      redirect to '/login' # error: 'We couldn't find you.  Have you signed up?'
    end
    @user.authenticate(params[:password])
    session[:id] = @user.id
    redirect to '/recipes'
  end

  get '/logout' do
    session.clear
    redirect to '/recipes'
  end

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    if !@user
      redirect to '/users'
    else
      @recipes = Recipe.where(user_id: @user.id)
      erb :'/recipes/index'
    end
  end

end
