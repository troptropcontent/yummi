class Line < ApplicationRecord
  belongs_to :meal
  belongs_to :order
end
