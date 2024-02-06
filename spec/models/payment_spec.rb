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
