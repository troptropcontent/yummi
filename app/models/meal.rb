class Meal < ApplicationRecord
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  belongs_to :user
  has_many :meal_categories
  has_many :meals, through: :meal_categories
  has_many :meal_courses
  has_many :courses, through: :meal_courses
  has_many :lines
  has_many :orders, through: :lines
  has_many :reviews, through: :orders
  validates :discount, inclusion: { in: 0..100 }

end
