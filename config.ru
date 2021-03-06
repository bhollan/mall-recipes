#mall-recipes config.ru
require 'pry'
# binding.pry
require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UsersController
use RecipesController
use ReviewsController
use IngredientsController
run ApplicationController
