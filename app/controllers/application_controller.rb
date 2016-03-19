#mall-recipes "app"
require './config/environment'
# binding.pry

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
    # if !is_logged_in
    #   erb :'users/create_user', layout: false
    # else
    #   erb :'recipes/index'
    # end
    "HELLO WORLD!!"
  end

end
