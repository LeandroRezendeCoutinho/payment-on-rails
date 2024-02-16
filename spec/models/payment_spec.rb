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
# spec/models/payment_spec.rb

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:payment_type) }
    it { should validate_presence_of(:source_type) }
  end

  describe 'monetize' do
    it { is_expected.to monetize(:amount_cents).as(:amount) }
  end
end
