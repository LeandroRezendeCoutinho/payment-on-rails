# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("BRL"), not null
#  capture         :boolean
#  status          :string
#  order_id        :string
#  payment_type    :string
#  source_type     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Payment < ApplicationRecord
  include PaymentEnumetations
  monetize :amount_cents, as: :amount

  validates :payment_type, :source_type, presence: true
end
