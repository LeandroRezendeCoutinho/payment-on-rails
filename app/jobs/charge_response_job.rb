class ChargeResponseJob < ApplicationJob
  queue_as :charge

  def perform(args)
    Rails.logger.info("Starting ChargeResponseJob: #{args}")
    update_status(args)
    send_response(args)
  end

  private

  def update_status(args)
    Charge.update(args.fetch('charge_id'), status: args.fetch('status'))
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
    logger.error("Charge request failed with error: #{e.message}")
    raise e
  end
end
