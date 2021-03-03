class User < ApplicationRecord
  acts_as_token_authenticatable
  has_many :meals
  has_many :lines, through: :meals
  has_many :orders
  has_many :orders_as_chef, through: :lines, source: :order
  has_many :reviews_as_chef, through: :orders_as_chef, source: :review
  has_many :schedules
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  def rating_average
    reviews_as_chef.average(:rating)
  end

  def distance_from_chef(chef)
    return self.distance_from([chef.latitude,chef.longitude]).round(2) if self.distance_from([chef.latitude,chef.longitude])
    return 5
  end
  
  # add geocoder to translate address into coordinates
  geocoded_by :home_address
    after_validation :geocode, if: :will_save_change_to_home_address?

end
