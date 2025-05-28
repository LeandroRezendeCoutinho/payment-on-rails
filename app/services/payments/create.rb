module Payments
  class Create
    def initialize(payment_id)
      @payment_id = payment_id
    end

    def self.call(payment_id)
      new(payment_id).call
    end

    def call
      payment = Payment.find(@payment_id)

      response = request(payment)
      parsed_response = JSON.parse(response.body) if response.success?

      if response.status == 200
        parsed_response['payment_id'] = payment.id
        parsed_response['status'] = 'authorized'
        PaymentProducer.call(parsed_response)
        Rails.logger.info("Payment id: #{@payment_id} response: #{parsed_response}")
      else
        Rails.logger.error("Payment request failed status: #{response.status} body: #{response.body}")
      end
    end

    private

    def request(payment)
      conn = Faraday.new(
        url: 'http://localhost:3500',
        headers: { 'Content-Type' => 'application/json' }
      )

      conn.post('/payments') do |req|
        req.body = {
          amount: payment.amount_cents,
          capture: payment.capture,
          status: payment.status || 'pending',
          order_id: payment.order_id,
          payment_type: payment.payment_type,
          source_type: payment.source_type
        }.to_json
      end
    rescue Faraday::Error => e
      Rails.logger.error("Payment request failed with error: #{e.message}")
      raise e
    end
  end
end
