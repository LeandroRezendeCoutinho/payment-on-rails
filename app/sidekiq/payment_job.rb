# frozen_string_literal: true

class PaymentJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: 5

  def perform(payment_id)
    PaymentService.new(payment_id).call
  end
end
