class Order < ApplicationRecord

  DELIVERY_OPTIONS = ["delivery", "pick and collect"]

  belongs_to :user
  has_many :lines, dependent: :destroy
  has_one :chatroom
  has_one :review
  after_create :create_chatroom


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
    lines.each{|line| total += line.meal.price_cents*line.quantity}
    total += delivery_fee_cents if delivery_fee_cents
    total
  end

<<<<<<< HEAD
=======
  private

  def create_chatroom
    #create a chatroom for the order
    Chatroom.create(order: self)
  end
>>>>>>> c3d0816996eaa9fab14ee0a184af2adef9aeef43

end
