ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

  # :adapter => "sqlite3",
  # :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :database => "db/#{ENV['SINATRA_ENV']}.sql"
)

require_all 'app/'
