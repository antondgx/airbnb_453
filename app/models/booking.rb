class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :property_id, presence: true
  validates :price, presence: true

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
