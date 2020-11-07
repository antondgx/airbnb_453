class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :properties
  has_many :bookings
  has_one_attached :avatar

  validates :username, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
