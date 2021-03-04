class Chatroom < ApplicationRecord
  has_many :messages , dependent: :destroy
  belongs_to :order
  belongs_to :user
end
