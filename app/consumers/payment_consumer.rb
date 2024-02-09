class PaymentConsumer
  include Hutch::Consumer
  consume 'payment.response'

  def process(args)
    # logger.info("Starting PaymentResponseJob: #{args}")
    response = args['subject']
    send_response(response)
    update_status(response)
  end

  private

  def update_status(args)
    Payment.update(args.fetch('payment_id'), status: args.fetch('status'))
  end

  def send_response(args)
    conn = Faraday.new(
      url: 'http://localhost:3500',
      headers: { 'Content-Type' => 'application/json' }
    )

    conn.post('/webhooks') do |req|
      req.body = {
        amount: args.fetch('amount'),
        capture: args.fetch('capture'),
        status: args.fetch('status'),
        order_id: args.fetch('order_id'),
        payment_type: args.fetch('payment_type'),
        source_type: args.fetch('source_type')
      }.to_json
    end
  rescue Faraday::Error => e
    logger.error("Payment request failed with error: #{e.message}")
    raise e
  end
end
