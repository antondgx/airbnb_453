class Order < ApplicationRecord
  belongs_to :user
  belongs_to :property
  monetize :amount_cents
end
