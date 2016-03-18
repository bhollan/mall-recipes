class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  validates :stars, inclusion: {in: 1..5}
end
