# frozen_string_literal: true

class PaymentJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: 5

  def perform(payment_id)
    Payments::Create.call(payment_id)
  end
end
