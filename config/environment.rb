ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

  # :adapter => "sqlite3",
  # :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# ActiveRecord::Base.establish_connection(
#   :adapter => "postgresql",
#   :database => "db/#{ENV['SINATRA_ENV']}.sql"
# )
#


configure :production, :development do
   db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

   ActiveRecord::Base.establish_connection(
     :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
     :host     => db.host,
     :username => db.user,
     :password => db.password,
     :database => db.path[1..-1],
     :encoding => 'utf8')
end



ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mall_recipes_production')
require_all 'app/'
