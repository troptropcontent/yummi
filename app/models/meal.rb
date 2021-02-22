class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_categories
  has_many :lines
  has_many :reviews
  validates :discount, inclusion: { in: 0..100 }
end
