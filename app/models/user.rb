class User < ApplicationRecord
  acts_as_token_authenticatable
  has_many :orders
  has_many :reviews
  has_many :meals
  has_many :schedules
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
  
  # add geocoder to translate address into coordinates
  geocoded_by :home_address
    after_validation :geocode, if: :will_save_change_to_home_address?

end
