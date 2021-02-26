class Order < ApplicationRecord
  belongs_to :user
  has_many :lines


  def total_before_checkout
    total = 0 
    lines.each{|line| total += line.meal.price_cents}
  end
  
end
