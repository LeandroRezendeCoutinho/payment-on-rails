# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("BRL"), not null
#  capture         :boolean
#  payment_type    :string
#  source_type     :string
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :bigint
#  integration_id  :bigint
#  order_id        :string
#
# Indexes
#
#  index_payments_on_client_id       (client_id)
#  index_payments_on_integration_id  (integration_id)
#
class Payment < ApplicationRecord
  include PaymentEnumetations
  monetize :amount_cents, as: :amount

  validates :payment_type, :source_type, presence: true
  belongs_to :client
  belongs_to :integration
end
