class PaymentService
  def initialize(payment_id)
    @payment_id = payment_id
  end

  def call
    charge = Payment.find(@payment_id)

    response = request(charge)
    parsed_response = JSON.parse(response.body) if response.success?

    raise StandardError, response.body unless response.status == 200

    parsed_response['payment_id'] = charge.id
    parsed_response['status'] = 'authorized'
    Rails.logger.info("Payment response: #{parsed_response}")
    PaymentProducer.call(parsed_response)
  end

  private

  def request(charge)
    conn = Faraday.new(
      url: 'http://localhost:3500',
      headers: { 'Content-Type' => 'application/json' }
    )

    conn.post('/payments') do |req|
      req.body = {
        amount: charge.amount_cents,
        capture: charge.capture,
        status: charge.status || 'pending',
        order_id: charge.order_id,
        payment_type: charge.payment_type,
        source_type: charge.source_type
      }.to_json
    end
  rescue Faraday::Error => e
    logger.error("Payment request failed with error: #{e.message}")
    raise e
  end
end
