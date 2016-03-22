class User < ActiveRecord::Base
  include Helper
  extend Helper
  has_many :recipes
  has_many :reviews
  has_secure_password

  validates :username, presence: true, length: {in: 1..20}
  validates :email, presence: true
  validates :password, length: {in: 4..48}, presence: true

end
