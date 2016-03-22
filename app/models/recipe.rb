class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates :name, :directions, presence: true
end
