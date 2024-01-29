class ChargeJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: 5

  def perform(charge_id)
    charge = Charge.find(charge_id)
    response = request(charge)
    charge.update!(status: response.fetch('status'))
  end

  private

  def request(charge)
    begin
      conn = Faraday.new(
        url: 'http://localhost:3500',
        headers: {'Content-Type' => 'application/json'}
      )

      response = conn.post('/charges') do |req|
        req.body = {
          amount: charge.amount_cents,
          capture: charge.capture,
          status: charge.status || 'pending',
          order_id:  charge.order_id,
          payment_type: charge.payment_type,
          source_type: charge.source_type
        }.to_json
      end

      parsed = JSON.parse(response.body) if response.success?
      parsed
    rescue Faraday::Error => e
      logger.error("Charge request failed with error: #{e}")
      raise e
    end
  end
end
