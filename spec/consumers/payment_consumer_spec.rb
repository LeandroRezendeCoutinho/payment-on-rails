require 'rails_helper'

describe PaymentConsumer do
  describe "#process" do
    let(:args) do
      {
        'subject' => {
          'payment_id' => 123,
          'status' => 'authorized',
          'amount' => 100,
          'capture' => true,
          'order_id' => 1,
          'payment_type' => 'credit',
          'source_type' => 'card'
        }
      }
    end

    describe 'when consuming a payment' do
      it 'updates the payment and sends a webhook' do
        allow(Payment).to receive(:update).with(123, status: 'authorized').and_return(true)
        stub_request(:post, 'http://localhost:3500/webhooks')
          .with(
            body: {
              amount: args['subject']['amount'],
              capture: args['subject']['capture'],
              status: args['subject']['status'],
              order_id: args['subject']['order_id'],
              payment_type: args['subject']['payment_type'],
              source_type: args['subject']['source_type']
            }.to_json
          )
          .to_return(status: 200, body: 'OK')

        PaymentConsumer.new.process(args)

        expect(Payment).to have_received(:update).with(123, status: 'authorized')
      end
    end
  end
end
