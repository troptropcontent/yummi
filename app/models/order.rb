class Order < ApplicationRecord
  belongs_to :user
  has_many :lines

  def random_order_number
    random_number = []
    5.times do
      random_number << ("A".."Z").to_a.sample
    end
    2.times do
      random_number << (0..9).to_a.sample
    end
    return random_number.join
  end

  def random_delivery_date
    today = DateTime.now
    random_number_days = (1..30).to_a.sample
    random_date = today - random_number_days
    return random_date.strftime('%d/%m/%y')
  end
  
  
  def total_before_checkout
    total = 0 
    lines.each{|line| total += line.meal.price_cents}
    total
  end
  
end
