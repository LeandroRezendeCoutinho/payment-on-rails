class Payment < ApplicationRecord
  include PaymentEnumetations
  monetize :amount_cents, as: :amount

  validates :payment_type, :source_type, presence: true
end
