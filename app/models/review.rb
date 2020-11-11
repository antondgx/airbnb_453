class Review < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :content, presence: true, length: { minimum: 10,
    too_short: "%Your comment needs to be at least {count} characters" }
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: (0..5) }
end
