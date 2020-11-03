class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :property_id, presence: true
  validates :price, presence: true
end
