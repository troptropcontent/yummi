class Course < ApplicationRecord
  has_many :meal_courses
  has_many :meals, through: :meal_courses
end
