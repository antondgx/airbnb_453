class Property < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :capacity, presence: true
  validates :user_id, presence: true

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
