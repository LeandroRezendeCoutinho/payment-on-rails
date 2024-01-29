class Charge < ApplicationRecord
  include ChargeEnumetations
  monetize :amount_cents, as: :amount

  validates :payment_type, :source_type , presence: true
end
