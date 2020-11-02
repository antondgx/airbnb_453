class Property < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  has_many :bookings, dependent: :destroy
end
