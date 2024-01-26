class ChargeJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: 5

  def perform(charge_id)
    charge = Charge.find(charge_id)
    response = request(charge)
    charge.update!(status: response.body.fetch('status'))
    response
  end

  private

  def request(charge)
    begin
      conn = Faraday.new(
        url: 'http://localhost:3000',
        headers: {'Content-Type' => 'application/json'}
      )

      response = conn.post('/charge') do |req|
        req.body = {amount: charge.amount_cents,
        capture: charge.capture,
        status: charge.status,
        order_id:  charge.order_id,
        payment_type: charge.payment_type,
        source_type: charge.source_type }.to_json
      end
    rescue Faraday::Error => e
      logger.error("Charge request failed with error: #{e}")
      raise e
    end
    response
  end
end
