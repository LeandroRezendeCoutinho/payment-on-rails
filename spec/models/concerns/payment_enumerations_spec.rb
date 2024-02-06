# spec/models/payment_enumerations_spec.rb

require 'rails_helper'

RSpec.describe 'PaymentEnumetations' do
  describe 'status' do
    it 'defines the correct status enumerations' do
      expect(Payment.status.values.map(&:to_sym)).to match_array([
                                                                   :pending,
                                                                   :pre_authorized,
                                                                   :authorized,
                                                                   :failed,
                                                                   :canceled,
                                                                   :voided,
                                                                   :refund_pending,
                                                                   :charged_back
                                                                 ])
    end
  end

  describe 'payment_type' do
    it 'defines the correct payment_type enumerations' do
      expect(Payment.payment_type.values.map(&:to_sym)).to match_array([
                                                                         :credit,
                                                                         :debit,
                                                                         :pix,
                                                                         :bank_slip
                                                                       ])
    end
  end

  describe 'source_type' do
    it 'defines the correct source_type enumerations' do
      expect(Payment.source_type.values.map(&:to_sym)).to match_array([
                                                                        :card,
                                                                        :token
                                                                      ])
    end
  end
end
