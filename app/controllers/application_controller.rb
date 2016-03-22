#mall-recipes "app"
require './config/environment'

class ApplicationController < Sinatra::Base
  extend Helper
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/' do
    if !is_logged_in
      erb :'users/create_user'
    else
      # erb :'recipes/index'
      redirect '/recipes'
    end
  end

end
