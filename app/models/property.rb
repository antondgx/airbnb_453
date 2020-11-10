class Property < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many_attached :photos
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :capacity, presence: true
  validates :user_id, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title_description_and_address,
    against: [:title, :description, :address],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
