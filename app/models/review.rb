class Review < ApplicationRecord
  RATING = ["1", "2", "3", "4", "5"]
  belongs_to :order
  belongs_to :user
end
