require 'rails_helper'

RSpec.describe Payments::Create do
  describe '#call' do
    let(:payment_id) { 123 }
    let(:charge) do
      instance_double('Payment', id: payment_id, amount_cents: 1000, capture: true, status: 'pending',
                                 order_id: 1, payment_type: 'credit', source_type: 'card')
    end
    let(:response_body) { { payment_id:, status: 'authorized' }.to_json }

    it 'makes a request to the external service and processes the response' do
      allow(Payment).to receive(:find).with(payment_id).and_return(charge)

      stub_request(:post, 'http://localhost:3500/payments')
        .with(
          body: {
            amount: charge.amount_cents,
            capture: charge.capture,
            status: charge.status || 'pending',
            order_id: charge.order_id,
            payment_type: charge.payment_type,
            source_type: charge.source_type
          }.to_json
        )
        .to_return(status: 200, body: response_body)

      expect(PaymentProducer).to receive(:call).with(JSON.parse(response_body))

      expect do
        Payments::Create.call(payment_id)
      end.not_to raise_error
    end

    it 'raises an error if the request fails' do
      allow(Payment).to receive(:find).with(payment_id).and_return(charge)

      stub_request(:post, 'http://localhost:3500/payments').to_raise(Faraday::Error.new('Connection failed'))

      expect do
        Payments::Create.call(payment_id)
      end.to raise_error(StandardError, 'Connection failed')
    end
  end
end
