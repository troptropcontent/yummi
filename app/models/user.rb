class User < ApplicationRecord
  acts_as_token_authenticatable
  has_many :orders
  has_many :reviews
  has_many :meals
  has_many :schedules
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
